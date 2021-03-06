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
      [:rooms, :reservations, :blocks, :blocked_reservations].each do |data|
        booking_manager.must_respond_to data
      end

      booking_manager.rooms.must_be_kind_of Array
      booking_manager.rooms.each do |room|
        room.must_be_kind_of Hash
      end

      booking_manager.reservations.must_be_kind_of Array
      booking_manager.reservations.must_equal []
      booking_manager.reservations.must_be_empty
    end

  end # initializer

  describe "display_room_list method" do

    it "returns all rooms in the hotel" do
      booking_manager = Hotel::BookingManager.new

      booking_manager.display_room_list.must_be_kind_of Array

      i = 0
      booking_manager.display_room_list.each do |room|
        room.must_equal booking_manager.rooms[i]
        i += 1
      end

    end

  end # display_room_list

  describe "reserve_room method" do

    before do
      @booking_manager = Hotel::BookingManager.new
    end

    it "creates a new reservation instance" do
      new_reservation = @booking_manager.reserve_room(1, '15-03-2018', '17-03-2018')
      new_reservation.must_be_instance_of Hotel::Reservation
    end

    it "raises an exception if the user tries to reserve an unavailable room" do
      new_reservation = @booking_manager.reserve_room(1, '15-03-2018', '17-03-2018')
      proc{ @booking_manager.reserve_room(1, '15-03-2018', '17-03-2018') }.must_raise ArgumentError
    end

    it "raises and exception if the user tries to reserve a room on dates for which it's blocked" do
      block = @booking_manager.set_block(5, '05-05-2018', '08-05-2018')
      proc{ @booking_manager.reserve_room(1, '05-05-2018', '08-05-2018') }.must_raise ArgumentError
    end

  end # reserve_room

  describe "display_reservations method" do

    it "returns all reservation instances within the specified date range" do

      booking_manager = Hotel::BookingManager.new

      reservation_one = booking_manager.reserve_room(1, '15-03-2018', '17-03-2018')
      reservation_two = booking_manager.reserve_room(2, '15-03-2018', '17-03-2018')
      reservation_three = booking_manager.reserve_room(3, '21-03-2018', '23-03-2018')

      booking_manager.display_reservations('15-03-2018', '17-03-2018').must_include reservation_one
      booking_manager.display_reservations('15-03-2018', '17-03-2018').must_include reservation_two
      booking_manager.display_reservations('15-03-2018', '17-03-2018').wont_include reservation_three
    end

    it "returns an empty array if no reservations match the specified dates" do

      booking_manager = Hotel::BookingManager.new

      booking_manager.reserve_room(1, '15-03-2018', '17-03-2018')
      booking_manager.reserve_room(2, '15-03-2018', '17-03-2018')

      booking_manager.display_reservations('21-03-2018', '23-03-2018').must_be_empty
      booking_manager.display_reservations('21-03-2018', '23-03-2018').must_equal []

    end

  end # display_reservations_list

  describe "display_available_rooms method" do
    before do
      @booking = Hotel::BookingManager.new
    end

    it "raises an exception if the check-in date is after the check-out date" do
      proc{ @booking.display_available_rooms('17-03-2018', '15-03-2018') }.must_raise ArgumentError
    end

    it "raises an exception if the check-in and check_out dates are the same" do
      proc{ @booking.display_available_rooms('17-03-2018', '15-03-2018') }.must_raise ArgumentError
    end

    it "returns an array of all available rooms and excludes rooms reserved on the same dates" do
      reserved_one = @booking.reserve_room(1, '15-03-2018', '17-03-2018')
      reserved_two = @booking.reserve_room(2, '15-03-2018', '17-03-2018')

      @booking.display_available_rooms('15-03-2018', '17-03-2018').must_be_instance_of Array
      @booking.display_available_rooms('15-03-2018', '17-03-2018').length.must_equal 18

      @booking.display_available_rooms('15-03-2018', '17-03-2018').wont_include 1
      @booking.display_available_rooms('15-03-2018', '17-03-2018').wont_include 2
    end

    it "returns all rooms in the hotel if there are no reservations for the specified dates" do
      @booking.display_available_rooms('15-03-2018', '17-03-2018').length.must_equal 20
    end

    it "returns an empty array if there are no available rooms" do
      20.times do |i|
        @booking.reserve_room(i+1, '15-03-2018', '17-03-2018')
      end
      @booking.display_available_rooms('15-03-2018', '17-03-2018').must_equal []
    end

    it "excludes a room if it has a reservation that overlaps with the requested dates at the front" do
      @booking.reserve_room(1, '15-03-2018', '17-03-2018')
      @booking.display_available_rooms('15-03-2018', '25-03-2018').wont_include 1
    end

    it "excludes a room if it has a reservation that overlaps with the requested dates at the back" do
      @booking.reserve_room(1, '20-03-2018', '25-03-2018')
      @booking.display_available_rooms('15-03-2018', '25-03-2018').wont_include 1
    end

    it "excludes a room if it has an exisiting reservation that is completely contained in the requested dates" do
      @booking.reserve_room(1, '20-03-2018', '25-03-2018')
      @booking.display_available_rooms('15-03-2018', '30-03-2018').wont_include 1
    end

    it "excludes a room if it has an exisiting reservation that completely contains the requested dates" do
      @booking.reserve_room(1, '15-03-2018', '30-03-2018')
      @booking.display_available_rooms('20-03-2018', '25-03-2018').wont_include 1
    end

    it "does not affect the availability array if there is a reservation completely before the requested dates" do
      @booking.reserve_room(1, '15-03-2018', '17-03-2018')
      @booking.display_available_rooms('15-04-2018', '17-04-2018').must_include 1
    end

    it "does not affect the availability array if there is a reservation completely after the requested dates" do
      @booking.reserve_room(1, '20-05-2018', '21-05-2018')
      @booking.display_available_rooms('15-04-2018', '17-04-2018').must_include 1
    end

    it "does not affect the availability array if there is a reservation that ends on the requested check-in date" do
      @booking.reserve_room(1, '13-04-2018', '15-04-2018')
      @booking.display_available_rooms('15-04-2018', '17-04-2018').must_include 1
    end

    it "does not affect the availability array if there is a reservation that starts on the requested check-out date" do
      @booking.reserve_room(1, '17-04-2018', '20-04-2018')
      @booking.display_available_rooms('15-04-2018', '17-04-2018').must_include 1
    end

    it "omits all rooms with reservations within the requested date range if it spans several small reservations" do
      @booking.reserve_room(1, '17-04-2018', '20-04-2018')
      @booking.reserve_room(2, '16-04-2018', '17-04-2018')
      @booking.reserve_room(3, '23-04-2018', '25-04-2018')

      @booking.display_available_rooms('15-04-2018', '25-04-2018').wont_include 1
      @booking.display_available_rooms('15-04-2018', '25-04-2018').wont_include 2
      @booking.display_available_rooms('15-04-2018', '25-04-2018').wont_include 3
    end

    it "does not inlcude rooms that have been blocked" do
      @booking.reserve_room(1, '15-03-2018', '17-03-2018')
      @booking.set_block(3, '15-03-2018', '17-03-2018')

      @booking.display_available_rooms('15-03-2018', '17-03-2018').wont_include 1
      @booking.display_available_rooms('15-03-2018', '17-03-2018').wont_include 2
      @booking.display_available_rooms('15-03-2018', '17-03-2018').wont_include 3
      @booking.display_available_rooms('15-03-2018', '17-03-2018').wont_include 4
    end

  end # display_available_rooms

  describe "set_block method" do

    before do
      @booking_manager = Hotel::BookingManager.new
    end

    it "creates a new block instance" do
      new_block = @booking_manager.set_block(5, '05-05-2018', '08-05-2018')
      new_block.must_be_instance_of Hotel::Block
    end

    it "raises an exception if the user attempts to reserve a block of more than 5 rooms" do
      proc { @booking_manager.set_block(10, '05-05-2018', '08-05-2018') }.must_raise ArgumentError
    end

    it "raises an exception if the user attempts to reserve a block of less than 2 rooms" do
      proc { @booking_manager.set_block(1, '05-05-2018', '08-05-2018') }.must_raise ArgumentError
      proc { @booking_manager.set_block(-1, '05-05-2018', '08-05-2018') }.must_raise ArgumentError
    end

    it "raises an exception if there are not enough rooms available for the block" do
      16.times do |i|
        @booking_manager.reserve_room(i + 1, '15-03-2018', '17-03-2018')
      end
      proc { @booking_manager.set_block(5, '15-03-2018', '17-03-2018')}.must_raise ArgumentError
    end

    it "does not allow a blocked room to be included in another block for the same dates" do
      first_block = @booking_manager.set_block(5, '05-05-2018', '08-05-2018')
      second_block = @booking_manager.set_block(5, '05-05-2018', '08-05-2018')

      second_block.rooms.wont_include first_block.rooms
    end

  end # set_block method

  describe "reserve_blocked_room" do
    before do
      @booking_manager = Hotel::BookingManager.new
      @block = @booking_manager.set_block(3, '05-05-2018', '08-05-2018')
    end

    it "creates a new reservation instance" do
      new_reservation = @booking_manager.reserve_blocked_room("B1", 1)
      new_reservation.must_be_instance_of Hotel::Reservation
    end

    it "raises an exception if there are no more rooms available in the block" do
      @booking_manager.reserve_blocked_room("B1", 1)
      @booking_manager.reserve_blocked_room("B1", 2)
      @booking_manager.reserve_blocked_room("B1", 3)

      proc{ @booking_manager.reserve_blocked_room("B1") }.must_raise ArgumentError
    end

  end

  describe "check_block_availability" do

    it "returns an array of rooms that have NOT been reserved from the block" do
      booking_manager = Hotel::BookingManager.new
      booking_manager.set_block(3, '05-05-2018', '08-05-2018')
      booking_manager.reserve_blocked_room("B1", 1)

      booking_manager.check_block_availability("B1").wont_include 1
      booking_manager.check_block_availability("B1").must_include 2
      booking_manager.check_block_availability("B1").must_include 3
      booking_manager.check_block_availability("B1").must_be_instance_of Array
    end

    it "returns an empty array if all rooms in the block have been booked" do
      booking_manager = Hotel::BookingManager.new
      booking_manager.set_block(3, '05-05-2018', '08-05-2018')

      booking_manager.reserve_blocked_room("B1", 1)
      booking_manager.reserve_blocked_room("B1", 2)
      booking_manager.reserve_blocked_room("B3", 3)

      booking_manager.check_block_availability.must_equal []

    end

  end

end
