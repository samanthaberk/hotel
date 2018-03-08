require 'date'
require 'pry'
require 'set' # this allows me to compare 2 sets of data and find where they intersect
require 'awesome_print'
require_relative 'validation'
require_relative 'reservation'
require_relative 'block'

module Hotel

  class BookingManager < Validation
    TOTAL_ROOMS = 20
    attr_reader :rooms, :reservations

    def initialize
      @rooms = load_rooms # an array of hashes containing room info
      @reservations = []
      @blocks = []
    end

    def display_room_list
      return @rooms
    end

    def load_rooms
      # load data for room numbers and booked dates
      rooms = []
      TOTAL_ROOMS.times do |room|
        rooms << {
          room_num: room + 1,
          booked_dates: [],
          is_block?: false
        }
      end

      return rooms

    end # load_rooms

    def reserve_room(room_num, check_in, check_out) # change hash to keyword arguments

      # check if the room is available on the requested dates
      available_rooms = display_available_rooms(check_in, check_out)
      if available_rooms.include?(room_num) == false
        raise ArgumentError.new("Room is not available for the requested dates")
      end

      # if it is available, load reservation data
      reservation_data = {
        id: @reservations.length + 1,
        room_num: room_num,
        check_in: Date.parse(check_in),
        check_out: Date.parse(check_out),
      }

      # use data to intantiate a new reservation and add it to the reservations list
      new_reservation = Reservation.new(reservation_data)
      @reservations.push(new_reservation)

      # add reservation to the room's hash
      dates = (Date.parse(check_in)...Date.parse(check_out)).to_a
      @rooms[room_num - 1][:booked_dates].push(dates)

      return new_reservation
    end

    def display_reservations(check_in, check_out)
      # Create a variable to keep track of all reservations that match the specified dates
      matching_reservations = []

      # Look at each reservation and add an instance to the above variable if the check-in and check-out dates match the given parameters
      @reservations.each do |reservation|
        if reservation.check_in == Date.parse(check_in) && reservation.check_out == Date.parse(check_out)
          matching_reservations << reservation
        end
      end

      return matching_reservations

    end # def reserve room

    def display_available_rooms(check_in, check_out)
      # Confirm valid dates
      check_date_validity(check_out, check_in)

      # Define date range to search for
      requested_dates = Set.new(Date.parse(check_in)...Date.parse(check_out))
      # Loop through all rooms add any that are NOT booked during the date range to available_rooms
      available_rooms = []
      @rooms.each do |room|
        if Set.new(room[:booked_dates].flatten).intersect?(requested_dates) == false
          available_rooms << room[:room_num]
        end
      end
      return available_rooms
    end #display_available_rooms

    def set_block(num_rooms, check_in, check_out)
      # Find available rooms for the block
      available_rooms = display_available_rooms(check_in, check_out)
      blocked_rooms = available_rooms.sample(num_rooms)

      # Load block data
      block_data = {
        id: "B" + (@blocks.length + 1).to_s,
        blocked_rooms: blocked_rooms,
        nightly_rate: 175.00
      }

    end

  end # booking manager class

end # hotel module

booking = Hotel::BookingManager.new
print booking.reserve_block(5, '15-03-2018', '17-03-2018')
# print booking.reserve_room(1, '15-03-2018', '17-03-2018')
# booking.reserve_room(2, '15-03-2018', '20-03-2018')
# booking.reserve_room(2, '20-03-2018', '21-03-2018')
# ap booking.display_available_rooms('15-03-2018', '17-03-2018')
