require_relative 'spec_helper'

describe "Booking Manager Class" do

  describe "Initializer" do
    it "is an instance of BookingManager" do
      booking_manager = Hotel::BookingManager.new
      booking_manager.must_be_kind_of Hotel::BookingManager
    end

    it "establishes the base data structures when instantiated" do
      booking_manager = Hotel::BookingManager.new
      [:rooms, :price, :reservations].each do |data|
        booking_manager.must_respond_to data
      end

      booking_manager.rooms.must_be_kind_of Array
      booking_manager.rooms.each do |room|
        room.must_be_kind_of Integer
      end

      booking_manager.price.must_be_kind_of Float
      booking_manager.price.must_equal 200.00

      booking_manager.reservations.must_be_kind_of Array
      booking_manager.reservations.must_equal []
    end



  end

end
