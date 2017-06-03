# frozen_string_literal: true
require_relative 'addressed_frame'

module XBee
	module Frames
		# This frame causes the device to send payload data as an RF packet to a specific destination.
		# * For broadcast transmissions, set the 64-bit destination address to 0x000000000000FFFF.
		#   Address the coordinator by either setting the 64-bit address to all 0x00s and the 16-bit address
		#   to 0xFFFE, or setting the 64-bit address to the coordinator's 64-bit address and the 16-bit
		#   address to 0x0000.
		# * For all other transmissions, setting the 16-bit address to the correct 16-bit address helps
		#   improve performance when transmitting to multiple destinations. If you do not know a 16-bit
		#   address, set this field to 0xFFFE (unknown). If successful, the Transmit Status frame (0x8B)
		#   indicates the discovered 16-bit address.
		#
		# You can set the broadcast radius from 0 up to NH. If set to 0, the value of NH specifies the broadcast
		# radius (recommended). This parameter is only used for broadcast transmissions.
		#
		# You can read the maximum number of payload bytes with the NP command.
		class TransmitRequest < AddressedFrame
			api_id 0x10

			attr_accessor :broadcast_radius
			attr_accessor :options
			attr_accessor :data


			OPTIONS = {
				0x01 => :disable_retries,
				0x20 => :enable_aps_encryption,
				0x40 => :extended_transmission_timeout,
			}.freeze

			class << self
				# Allocates and returns an instance pre-addressed as a broadcast.
				def broadcast
					new.tap do |frame|
						frame.address64 = Address64::BROADCAST
					end
				end


				# Allocates and returns an instance pre-addressed for the coordinator node.
				def coordinator
					new.tap do |frame|
						frame.address64 = Address64::COORDINATOR
						frame.address16 = Address16::COORDINATOR
					end
				end
			end


			def initialize(packet: nil)
				super

				if @parse_bytes
					@broadcast_radius = @parse_bytes.shift
					@options = @parse_bytes.shift
					@data = @parse_bytes
					@parse_bytes = []
				end
			end


			def bytes
				super + [broadcast_radius || 0x00] + [options || 0x00] + (data || [])
			end
		end
	end
end
