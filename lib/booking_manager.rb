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

  end # booking manager class

end # hotel module

# booking_manager = Hotel::BookingManager.new
# print booking_manager.display_room_list
