require 'date'
require_relative 'spec_helper'

describe 'Room Class' do

  describe 'Initializer' do

    it "is an instance of Room" do
      new_room = Hotel::Room.new
      new_room.must_be_kind_of Hotel::Room
    end

  end # initializer

end
