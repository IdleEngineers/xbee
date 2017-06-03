# frozen_string_literal: true
require_relative 'frame'
require_relative 'data/sample'

module XBee
	module Frames
		class DataSampleRXIndicator < Frame
			api_id 0x92

			attr_reader :address16
			attr_reader :address64
			attr_reader :options

			# [Array<Data::DataSample>] Array of sample objects
			attr_reader :samples


			OPTION_BITS = {
				0x01 => :acknowledged,
				0x02 => :broadcast,
			}.freeze


			def initialize(packet: nil)
				@samples = []

				super

				if @parse_bytes
					@address64 = Address64.new *@parse_bytes.shift(8)
					@address16 = Address16.new *@parse_bytes.shift(2)
					@options = @parse_bytes.shift
					@number_of_samples = @parse_bytes.shift
					@number_of_samples.times do
						@samples << Data::Sample.new(parse_bytes: @parse_bytes)
					end
				end
			end


			def bytes
				super +
					(address64 || Address64::COORDINATOR).to_a +
					(address16 || Address16::COORDINATOR).to_a +
					[options || 0x00] +
					[(samples || []).length] +
					samples.map(&:to_a).reduce(:+)
			end
		end
	end
end
