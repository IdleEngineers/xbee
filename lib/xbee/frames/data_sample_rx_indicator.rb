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


			RECEIVE_OPTIONS = {
				0x01 => :acknowledged,
				0x02 => :broadcast,
			}.freeze

			def initialize(packet: nil)
				@samples = []

				super

				if @parse_bytes
					@address64 = Address64.new *@parse_bytes.shift(8)
					@address16 = Address16.new *@parse_bytes.shift(2)
					# reserved
					@parse_bytes.shift 2
					@receive_options = @parse_bytes.shift
					@number_of_samples = @parse_bytes.shift
					@number_of_samples.times do
						@samples << Data::DataSample.new(parse_bytes: @parse_bytes)
					end
				end
			end
		end
	end
end
