require 'date'

module Hotel

  class Reservation
    attr_accessor :check_in, :check_out

    def initialize(check_in, check_out)
      if check_out < check_in
        raise ArgumentError.new("Check-out date cannot be earlier than check-in.")
      end

      if check_out == check_in
        raise ArgumentError.new("Check-in and check-out dates cannot be the same.")
      end

      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
    end # constructor

  end # reservation class

end # hotel module
