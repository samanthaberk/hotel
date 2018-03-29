require 'date'

module Hotel

  class Validation

    def find_date_range(check_in, check_out)
      requested_dates = Set.new(Date.parse(check_in)...Date.parse(check_out))
    end

    def reserved_for_dates?(room, requested_dates)
      Set.new(room[:booked_dates].flatten).intersect?(requested_dates)
    end

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

    def check_block_validity(num_rooms)
      if num_rooms > 5
        raise ArgumentError.new("Cannot set more than 5 rooms in a block")
      elsif num_rooms < 2
        raise ArgumentError.new("Must set a minimum of 2 rooms in a block")
      end
    end

  end # validation class

end # hotel module
