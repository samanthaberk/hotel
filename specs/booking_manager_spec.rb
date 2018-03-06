require 'date'
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
      booking_manager.reservations.must_be_empty
    end

  end # initializer

  describe "display_room_list method" do

    it "returns all rooms in the hotel" do
      booking_manager = Hotel::BookingManager.new

      booking_manager.display_room_list.must_be_kind_of Array
      booking_manager.display_room_list.must_equal Array(1..20)
    end

  end # display_room_list

  describe "reserve_room method" do

    before do
      @booking_manager = Hotel::BookingManager.new
    end

    it "creates a new reservation instance" do
      new_reservation = @booking_manager.reserve_room('15-03-2018', '17-03-2018')
      new_reservation.must_be_instance_of Hotel::Reservation
    end

    it "selects a room between 1 and 20 for the reservation" do
      new_reservation = @booking_manager.reserve_room('15-03-2018', '17-03-2018')
      new_reservation.room_num.must_be :>, 0
      new_reservation.room_num.must_be :<, 21
    end

    it "assigns an id to the reservation based on the total number of reservations" do
      reservation_one = @booking_manager.reserve_room('15-03-2018', '17-03-2018')
      reservation_one.id.must_equal 1

      reservation_two = @booking_manager.reserve_room('18-03-2018', '20-03-2018')
      reservation_two.id.must_equal 2

      reservation_three = @booking_manager.reserve_room('21-03-2018', '23-03-2018')
      reservation_three.id.must_equal 3
    end

  end

end
