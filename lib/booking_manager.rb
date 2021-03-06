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
    attr_reader :rooms, :reservations, :blocks, :blocked_reservations

    def initialize
      @rooms = load_rooms # an array of hashes containing room info
      @reservations = []
      @blocks = []
      @blocked_reservations = []
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
        nightly_rate: 200.0
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
      requested_dates = find_date_range(check_in, check_out)

      # Loop through all rooms add any that are NOT booked during the date range to available_rooms
      available_rooms = []
      @rooms.each do |room|
        if !reserved_for_dates?(room, requested_dates) && !blocked_for_dates?(room, requested_dates)
          available_rooms << room[:room_num]
        end
      end

      return available_rooms
    end #display_available_rooms

    def blocked_for_dates?(room, requested_dates)
      @blocks.each do |block|
        if Set.new(block.dates).intersect?(requested_dates) && block.rooms.include?(room[:room_num])
          return true
        end
      end
      return false
    end

    def set_block(num_rooms, check_in, check_out)
      # Check validity of request
      check_block_validity(num_rooms)
      check_date_validity(check_out, check_in)

      # Find available rooms for the block
      available_rooms = display_available_rooms(check_in, check_out)
      blocked_rooms = []
      if available_rooms.length >= num_rooms
        blocked_rooms = available_rooms[0...num_rooms]
      else
        raise ArgumentError.new("There are only #{available_rooms.length} rooms available on these dates.")
      end

      # Change selected rooms' blocked status
      blocked_rooms.each do |room|
        @rooms[room-1][:is_block] = true
      end

      # Load block data
      block_data = {
        id: "B" + (@blocks.length + 1).to_s,
        rooms: blocked_rooms,
        dates: Date.parse(check_in)...Date.parse(check_out)
      }

      # use data to intantiate a new block and add it to the block list
      new_block = Block.new(block_data)
      @blocks.push(new_block)

      return new_block
    end

    def check_block_availability(block_id)
      # Find the specific block by its id
      block = @blocks.find do |block|
        block.id == block_id
      end

      # Isolate rooms in the block that have already been reserved
      reserved_blocked_rooms = []
      @blocked_reservations.each do |reservation|
        reserved_blocked_rooms << reservation.room_num
      end

      # Compare each room in the block to the list of reserved block rooms
      available_rooms_in_block = []
      block.rooms.each do |room|
        if reserved_blocked_rooms.include?(room) == false
          available_rooms_in_block << room
        end
      end

      return available_rooms_in_block

    end

    def reserve_blocked_room(block_id, room_num)
      # check if the room is available in the block
      available_rooms = check_block_availability(block_id)
      if available_rooms.include?(room_num) == false
        raise ArgumentError.new("Room is not available")
      end

      # Find the specific block by its id
      block = @blocks.find do |block|
        block.id == block_id
      end

      # if it is available, load reservation data
      reservation_data = {
        id: @blocked_reservations.length + 1,
        room_num: room_num,
        check_in: block.dates.first,
        check_out: block.dates.last,
        nightly_rate: 175.00,
      }

      # use data to intantiate a new reservation and add it to the reservations list
      new_reservation = Reservation.new(reservation_data)
      @blocked_reservations.push(new_reservation)
      return new_reservation

    end # reserve_blocked_room

  end # booking manager class

end # hotel module

booking = Hotel::BookingManager.new
booking.set_block(5, '05-05-2018', '08-05-2018')
booking.reserve_blocked_room("B1", 1)
# puts ""
ap booking.check_block_availability("B1")

ap booking.display_available_rooms('15-03-2018', '17-03-2018')

# booking.reserve_room(2, '15-03-2018', '17-03-2018')

# ap booking.rooms[0][:is_block]
