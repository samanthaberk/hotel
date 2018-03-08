# require 'date'
# require_relative 'spec_helper'
#
# describe 'Room Class' do
#
#   describe 'Initializer' do
#
#     it "is an instance of Room" do
#       new_room = Hotel::Room.new(1)
#       new_room.must_be_kind_of Hotel::Room
#     end
#
#     it "initializes with a valid room number that exists in the hotel" do
#       first_new_room = Hotel::Room.new(10)
#       first_new_room.room_num.must_be_instance_of Integer
#
#       invalid_new_room = Hotel::Room.new(21)
#       invalid_new_room.room_num.must_raise ArgumentError
#
#       invalid_new_room = Hotel::Room.new(-1)
#       invalid_new_room.room_num.must_raise ArgumentError
#     end
#
#     it "initializes with full availability (i.e. no dates are booked)" do
#       @room_num.booked_dates.must_be_instance_of Array
#       @room_num.booked_dates.must_be_empty
#       @room_num.booked_dates.must_equal []
#     end
#
#   end # initializer
#
# end
