require_relative 'spec_helper'

describe "Reservation class" do

  describe "Reservation instantiation" do

    it "is an instance of Reservation" do
      new_reservation = Hotel::Reservation.new({id: 1, room_num: 1, check_in: '15-03-2018', check_out: '17-03-2018'})
      new_reservation.must_be_kind_of Hotel::Reservation
    end

    it "raises and exception if the room number does not exist" do
      proc{ Hotel::Reservation.new({id: 1, room_num: 34, check_in: '15-03-2018', check_out: '17-03-2018'})}
    end

    it "raises an exception if the check-in date is after the check-out date" do
      proc{ Hotel::Reservation.new({id: 1, room_num: 2, check_in: '17-03-2018', check_out: '15-03-2018'})}.must_raise ArgumentError
    end

    it "raises an exception if the check-in and check_out dates are the same" do
      proc{ Hotel::Reservation.new({id: 1, room_num: 2, check_in: '17-03-2018', check_out: '17-03-2018'})}.must_raise ArgumentError
    end

  end # constructor

  describe "duration_of_stay method" do

    it "Adds the total number of days in the reservation, not including the check-out day" do
      new_reservation = Hotel::Reservation.new({id: 1, room_num: 1, check_in: '15-03-2018', check_out: '17-03-2018'})

      new_reservation.duration_of_stay.must_equal 2
      new_reservation.duration_of_stay.must_be_instance_of Integer
      new_reservation.duration_of_stay.wont_equal 3

    end

  end

end
