# frozen_string_literal: true
require_relative 'addressed_frame'

module XBee
	module Frames
		# Use this frame to query or set device parameters on the local device. This API command applies
		# changes after running the command. You can query parameter values by sending the 0x08 AT
		# Command frame with no parameter value field (the two-byte AT command is immediately followed by
		# the frame checksum).
		class RemoteATCommandRequest < AddressedFrame
			api_id 0x17

			OPTIONS = {
				0x01 => :disable_ack,
				0x40 => :extended_transmission_timeout,
			}.freeze

			attr_accessor :at_command
			attr_accessor :command_parameter
			attr_accessor :remote_command_options


			def initialize(packet: nil)
				@address16 = Address16::BROADCAST

				super

				if @parse_bytes
					@remote_command_options = @parse_bytes.shift
					@at_command = @parse_bytes.shift 2
					@command_parameter = @parse_bytes
					@parse_bytes = []
				end
			end


			# @param value [Array/String] The AT command. Must be two bytes, either an array or a string.
			def at_command=(value)
				raise ArgumentError, "AT command must be exactly two bytes (got #{value.inspect})" unless value.length == 2
				if value.respond_to?(:force_encoding)
					@at_command = value.dup.force_encoding('ASCII').unpack 'C*'
				else
					@at_command = value
				end
			end


			def bytes
				super + [remote_command_options || 0x00] + (at_command || [0] * 2) + (command_parameter || [])
			end
		end
	end
end
