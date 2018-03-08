require 'date'

module Hotel

  class Validation

    def check_date_validity(check_out, check_in)
      if check_in > check_out
        raise ArgumentError.new("Check-out date cannot be earlier than check-in.")
      elsif check_out == check_in
        raise ArgumentError.new("Check-in and check-out dates cannot be the same.")
      end
    end

    def check_valid_room(room_num)
      if room_num > 20 || room_num < 1
        raise ArgumentError.new("Invalid room number.")
      end
    end

  end # validation class

end # hotel module
