# frozen_string_literal: true
require_relative 'frame'
require_relative 'data/data_sample'

module XBee
	module Frames
		class TransmitRequest < Frame
			api_id 0x10

			attr_accessor :id
			attr_accessor :address16
			attr_accessor :address64
			attr_accessor :broadcast_radius
			attr_accessor :options
			attr_accessor :data


			def initialize(packet: nil)
				@samples = []

				super

				if raw_data
					input = raw_data.dup
					@id = input.shift
					@address64 = Address64.new *input.shift(8)
					@address16 = Address16.new *input.shift(2)
					@broadcast_radius = input.shift
					@options = input.shift
					@data = input
				end
			end
		end
	end
end
