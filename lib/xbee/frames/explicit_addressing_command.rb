# frozen_string_literal: true
require_relative 'addressed_frame'

module XBee
	module Frames
		# This frame is similar to Transmit Request (0x10), but it also requires you to specify the application-
		# layer addressing fields: endpoints, cluster ID, and profile ID.
		#
		# This frame causes the device to send payload data as an RF packet to a specific destination, using
		# specific source and destination endpoints, cluster ID, and profile ID.
		#
		# * For broadcast transmissions, set the 64-bit destination address to 0x000000000000FFFF .
		#   Address the coordinator by either setting the 64-bit address to all 0x00s and the 16-bit address
		#   to 0xFFFE, or setting the 64-bit address to the coordinator's 64-bit address and the 16-bit
		#   address to 0x0000.
		#
		# * For all other transmissions, setting the 16-bit address to the correct 16-bit address helps
		#   improve performance when transmitting to multiple destinations. If you do not know a 16-bit
		#   address, set this field to 0xFFFE (unknown). If successful, the Transmit Status frame (0x8B)
		#   indicates the discovered 16-bit address.
		#
		# You can set the broadcast radius from 0 up to NH to 0xFF. If set to 0, the value of NH specifies the
		# broadcast radius (recommended). This parameter is only used for broadcast transmissions.
		#
		# You can read the maximum number of payload bytes with the NP command.
		class ExplicitAddressingCommand < AddressedFrame
			api_id 0x11

			attr_accessor :source_endpoint
			attr_accessor :destination_endpoint
			attr_accessor :cluster_id # 2 bytes
			attr_accessor :profile_id # 2 bytes
			attr_accessor :broadcast_radius
			attr_accessor :transmission_options
			attr_accessor :data


			OPTIONS = {
				0x01 => :disable_retries,
				0x08 => :multicast_addressing,
				0x20 => :enable_aps_encryption,
				0x40 => :extended_transmission_timeout,
			}.freeze



			def initialize(packet: nil)
				super

				if @parse_bytes
					@source_endpoint = @parse_bytes.shift
					@destination_endpoint = @parse_bytes.shift
					@cluster_id = @parse_bytes.shift 2
					@profile_id = @parse_bytes.shift 2
					@broadcast_radius = @parse_bytes.shift
					@transmission_options = @parse_bytes.shift
					@data = @parse_bytes
					@parse_bytes = []
				end
			end


			def bytes
				super + [options || 0x00] + (data || [])
			end
		end
	end
end
