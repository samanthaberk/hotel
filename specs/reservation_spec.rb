require_relative 'spec_helper'

describe "Reservation class" do

  describe "Reservation instantiation" do

    it "is an instance of Reservation" do
      new_reservation = Hotel::Reservation.new('15-03-2018', '17-03-2018')
      new_reservation.must_be_kind_of Hotel::Reservation
    end

  end

end
