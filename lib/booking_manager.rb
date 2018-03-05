module Hotel

  class BookingManager
    attr_accessor :rooms, :price, :reservations

    def initialize
      @rooms = Array(1..20)
      @price = 200.00
      @reservations = []
    end
  end

end
