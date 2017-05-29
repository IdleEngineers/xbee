# frozen_string_literal: true
require_relative 'frame'
require_relative '../bytes'

module XBee
	module Frames
		# When a device configured with explicit API Rx Indicator (AO = 1) receives an RF packet, it sends it out
		# the serial interface using this message type.
		class ExplicitRXIndicator < Frame
			api_id 0x91


			OPTION_BITS = {
				0x01 => 'Acknowledged',
				0x02 => 'Broadcast packet',
				0x20 => 'Encrypted with APS encryption',
			}.freeze


			attr_accessor :address64
			attr_accessor :address16
			attr_accessor :source_endpoint # 8-bit scalar
			attr_accessor :destination_endpoint # 8-bit scalar
			attr_accessor :cluster_id # 16-bit scalar
			attr_accessor :profile_id # 16-bit scalar
			attr_accessor :options # 8-bit scalar
			attr_accessor :data # 0-n bytes


			def initialize(packet: nil)
				super

				if @parse_bytes
					@address64 = Address64.new *@parse_bytes.shift(8)
					@address16 = Address16.new *@parse_bytes.shift(2)
					@source_endpoint = @parse_bytes.shift
					@destination_endpoint = @parse_bytes.shift
					@cluster_id = Bytes.unsigned_int_from_array @parse_bytes.shift(2)
					@profile_id = Bytes.unsigned_int_from_array @parse_bytes.shift(2)
					@options = @parse_bytes.shift
					@data = @parse_bytes
					@parse_bytes = []
				end
			end


			def bytes
				super +
					(address64 || Address64.from_array([0] * 8)).to_a +
					(address16 || Address16.new(0, 0)).to_a +
					[source_endpoint || 0x00] +
					[destination_endpoint || 0x00] +
					Bytes.array_from_unsigned_int(cluster_id || 0) +
					Bytes.array_from_unsigned_int(profile_id || 0) +
					[options || 0x00] +
					(data || [])
			end
		end
	end
end
