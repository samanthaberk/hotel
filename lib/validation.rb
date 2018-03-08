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

  end # validation class

end # hotel module
