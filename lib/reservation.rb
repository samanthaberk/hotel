############ ARGUMENT ERROR IF YOU TRY TO RESERVE A ROOM THAT IS NOT AVAILABLE ############

require 'date'
# require_relative 'booking_manager'

module Hotel

  class Reservation
    attr_reader :id, :room_num, :check_in, :check_out, :nightly_rate

    def initialize(reservation_data)
      @id = reservation_data[:id]
      @room_num = reservation_data[:room_num]
      @check_in = reservation_data[:check_in]
      @check_out = reservation_data[:check_out]
      @nightly_rate = 200.00

      # Check for validity of room number and dates
      if @id > 20 || @id < 1
        raise ArgumentError.new("Invalid room number.")
      elsif @check_out < @check_in
        raise ArgumentError.new("Check-out date cannot be earlier than check-in.")
      elsif @check_out == @check_in
        raise ArgumentError.new("Check-in and check-out dates cannot be the same.")
      end

    end # constructor

    def duration_of_stay
      return (Date.parse(@check_out) - Date.parse(@check_in)).to_i
    end

    def calculate_reservation_cost
      duration = duration_of_stay
      return @nightly_rate * duration
    end

  end # reservation class

end # hotel module

# new_reservation = Hotel::Reservation.new({id: 1, room_num: 1, check_in: '15-03-2018', check_out: '17-03-2018'})
# print new_reservation.room_num
# print new_reservation.check_in
