require 'date'
require_relative 'spec_helper'

describe "Block Class" do

  describe "Initializer" do

    it "is an instance of Block" do
      new_block = Hotel::Block.new({id: "B1", rooms: [19, 11, 14, 13, 6], nightly_rate: 175.0})
      new_block.must_be_kind_of Hotel::Block
    end

  end # Describe Initializer

end # Describe Block Class
