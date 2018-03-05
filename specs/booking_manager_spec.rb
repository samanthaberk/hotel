require_relative 'spec_helper'

describe "Booking Manager Class" do

  describe "Initializer" do
    it "is an instance of BookingManager" do
      booking_manager = Hotel::BookingManager.new
      booking_manager.must_be_kind_of Hotel::BookingManager
    end
    
  end

end
