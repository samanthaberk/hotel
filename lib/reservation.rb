require 'date'
require_relative 'booking_manager'

module Hotel

  class Reservation
    attr_accessor :id, :room_num, :check_in, :check_out

    def initialize(reservation_data)
      @id = reservation_data[:id]
      @room_num = reservation_data[:room_num]
      @check_in = Date.parse(reservation_data[:check_in])
      @check_out = Date.parse(reservation_data[:check_out])

      # Check for validity of room number and dates
      if @id > 20 || @id < 1
        raise ArgumentError.new("Invalid room number.")
      elsif @check_out < @check_in
        raise ArgumentError.new("Check-out date cannot be earlier than check-in.")
      elsif @check_out == @check_in
        raise ArgumentError.new("Check-in and check-out dates cannot be the same.")
      end

    end # constructor

  end # reservation class

end # hotel module
