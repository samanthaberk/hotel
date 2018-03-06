require 'date'
require 'pry'

module Hotel

  class BookingManager
    attr_accessor :rooms, :price, :reservations

    def initialize
      @rooms = Array(1..20)
      @reservations = []
    end # constructor

    def display_room_list
      return @rooms
    end

    def reserve_room(check_in, check_out)
      # load reservation data
      reservation_data = {
        id: @reservations.length + 1,
        room_num: @rooms.sample,
        check_in: check_in,
        check_out: check_out
      }

      new_reservation = Reservation.new(reservation_data)
      @reservations.push(new_reservation)

      return new_reservation
    end

    def display_reservations(check_in, check_out)
      matching_reservations = []
      @reservations.each do |reservation|
        if reservation.check_in == Date.parse(check_in) && reservation.check_out == Date.parse(check_out)
          matching_reservations << reservation
        end
      end
      return matching_reservations

    end

  end # booking manager class

end # hotel module
