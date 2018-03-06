require 'date'
require 'pry'

module Hotel

  class BookingManager
    TOTAL_ROOMS = 20
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = load_rooms # an array of hashes containing room info
      @reservations = [] # starts out empty
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
          booked_dates: []
        }
      end

      return rooms

    end # load_rooms

    def reserve_room(room_num, check_in, check_out)
      # load reservation data
      reservation_data = {
        id: @reservations.length + 1,
        room_num: room_num,
        check_in: check_in,
        check_out: check_out
      }

      # use data to intantiate a new reservation and add it to the reservations list
      new_reservation = Reservation.new(reservation_data)
      @reservations.push(new_reservation)

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
      available_rooms
      # CREATE ROOM HASH containing a room_number and booked_dates (an array of arrays)
        # Later add is_block?

      # DISPLAY_AVAILABLE_ROOMS METHOD
      # Create VARIABLE ARRAY called available_rooms to store available rooms for the given date parameters
      # Find all dates you need to be available by calling duration, and adding 1 to check-in date as many times as the duration
      # Save to VARIABLE ARRAY as requested_dates
      # LOOP thru @rooms to look at each ROOM {room: 1, dates: [[10/30, 10/31], [11/02, 11/03, 11/04]], is_block?: false}
      # LOOP thru each room hash and look at the booked dates
      # If any of the requested_dates are present, do nothing
      # ELSE push the room instance to the available_rooms array
      # END
      #END
      #END
      # RETURN available rooms

    end

  end # booking manager class

end # hotel module

booking = Hotel::BookingManager.new
print booking.rooms
