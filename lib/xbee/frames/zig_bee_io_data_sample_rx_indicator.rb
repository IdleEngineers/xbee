# frozen_string_literal: true
require_relative 'frame'
require_relative 'data/data_sample'

module XBee
	module Frames
		class ZigBeeIODataSampleRxIndicator < Frame
			api_id 0x92


			# [Array<Data::DataSample>] Array of sample objects
			attr_reader :samples

			def initialize(packet: nil)
				@samples = []

				super
				# Receive options: 01
				# Number of samples: 01
				# Digital channel mask: 00 10
				# Analog channel mask: 00
				# DIO4/AD4 digital value: Low
				# Checksum: 4A
				if data
					input = data.dup
					@number_of_samples = input.shift

					@number_of_samples.times do
						@samples << Data::DataSample.new(bytes: input)
					end
				end
			end
		end
	end
end
