require 'date'

module Hotel

  class BookingManager
    attr_accessor :rooms, :price, :reservations

    def initialize
      @rooms = Array(1..20)
      @price = 200.00
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

      new_reservation = Hotel::Reservation.new(reservation_data)
      @reservations.push(new_reservation)

      return new_reservation
    end

  end # booking manager class

end # hotel module

# booking_manager = Hotel::BookingManager.new
# booking_manager.reserve_room('15-03-2018', '17-03-2018')
#
# new_reservation = Hotel::Reservation.new({id: 1, room_num: 34, check_in: '15-03-2018', check_out: '17-03-2018'})
# new_reservation.update_reservation_list
# puts @reservations
