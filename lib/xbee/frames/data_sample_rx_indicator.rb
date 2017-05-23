# frozen_string_literal: true
require_relative 'frame'
require_relative 'data/data_sample'

module XBee
	module Frames
		class DataSampleRxIndicator < Frame
			api_id 0x92

			attr_reader :address16
			attr_reader :address64
			attr_reader :receive_options

			# [Array<Data::DataSample>] Array of sample objects
			attr_reader :samples

			def initialize(packet: nil)
				@samples = []

				super

				if raw_data
					input = raw_data.dup
					@address64 = Address64.new *input.shift(8)
					@address16 = Address16.new *input.shift(2)
					@receive_options = input.shift
					@number_of_samples = input.shift
					@number_of_samples.times do
						@samples << Data::DataSample.new(bytes: input)
					end
				end
			end
		end
	end
end
