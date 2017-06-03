# frozen_string_literal: true
require_relative 'addressed_frame'

module XBee
	module Frames
		# If a device receives this frame in response to a Remote Command Request (0x17) frame, the device
		# sends an AT Command Response (0x97) frame out the serial interface.
		# Some commands, such as the ND command, may send back multiple frames.
		class RemoteATCommandResponse < AddressedFrame
			api_id 0x97

			attr_accessor :at_command
			attr_accessor :status
			attr_accessor :data


			# Possible values for +status+
			STATUS = {
				0 => :ok,
				1 => :error,
				2 => :invalid_command,
				3 => :invalid_parameter,
				4 => :transmission_failed,
			}.freeze


			def initialize(packet: nil)
				super

				if @parse_bytes
					@at_command = @parse_bytes.shift 2
					@status = @parse_bytes.shift
					@data = @parse_bytes
					@parse_bytes = []
				end
			end


			def bytes
				super + (command || [0x00] * 2) + [status || 0x00] + (data || [])
			end

		end
	end
end
