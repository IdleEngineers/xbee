# frozen_string_literal: true
require_relative 'frame'
require_relative 'data/data_sample'

module XBee
	module Frames
		class ATCommandQueueParameterValue < Frame
			api_id 0x09

			attr_accessor :id
			attr_reader :command_bytes
			# attr_accessor :command
			attr_reader :parameter_bytes
			# attr_accessor :parameter


			def initialize(packet: nil)
				@samples = []

				super

				if raw_data
					input = raw_data.dup
					@id = input.shift
					@command_bytes = input.shift 2
					@parameter_bytes = input
				end
			end
		end
	end
end
