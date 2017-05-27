# frozen_string_literal: true
require_relative 'identified_frame'

module XBee
	module Frames
		# Use this frame to query or set device parameters on the local device. This API command applies
		# changes after running the command. You can query parameter values by sending the 0x08 AT
		# Command frame with no parameter value field (the two-byte AT command is immediately followed by
		# the frame checksum).
		class ATCommand < IdentifiedFrame
			api_id 0x08

			attr_accessor :command_bytes
			# attr_accessor :command
			attr_accessor :parameter_bytes
			# attr_accessor :parameter


			def initialize(packet: nil)
				@samples = []

				super

				if @parse_bytes
					@command_bytes = @parse_bytes.shift 2
					@parameter_bytes = @parse_bytes
					@parse_bytes = []
				end
			end


			def bytes
				super + command_bytes + (parameter_bytes || [])
			end
		end
	end
end
