# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		# When a device configured with a standard API Rx Indicator (AO = 0) receives an RF data packet, it
		# sends it out the serial interface using this message type.
		class ReceivePacket < Frame
			api_id 0x90


			OPTION_BITS = {
				0x01 => 'Acknowledged',
				0x02 => 'Broadcast packet',
				0x20 => 'Encrypted with APS encryption',
				0x40 => 'End device',
			}.freeze


			attr_accessor :address64
			attr_accessor :address16
			attr_accessor :options
			attr_accessor :data


			def initialize(packet: nil)
				super

				if @parse_bytes
					@address64 = Address64.new *@parse_bytes.shift(8)
					@address16 = Address16.new *@parse_bytes.shift(2)
					@options = @parse_bytes.shift
					@data = @parse_bytes
					@parse_bytes = []
				end
			end


			def bytes
				super + (address64 || Address64.from_array([0] * 8)).to_a + (address16 || Address16.new(0, 0)).to_a + [options || 0x00] + (data || [])
			end
		end
	end
end
