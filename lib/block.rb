require 'date'
require_relative 'validation'

module Hotel

  class Block < Validation
    attr_reader :id, :rooms, :nightly_rate, :dates

    def initialize(block_data)
      @id = block_data[:id]
      @rooms = block_data[:rooms]
      @nightly_rate = block_data[:nightly_rate]
      @dates = block_data[:dates]
    end

  end

end
