# frozen_string_literal: true
require_relative 'unidentified_addressed_frame'
require_relative '../bytes'

module XBee
	module Frames
		class NodeIdentificationIndicator < UnidentifiedAddressedFrame
			api_id 0x95

			attr_accessor :options
			attr_accessor :source_address16
			attr_accessor :source_address64
			attr_accessor :parent_address16
			attr_accessor :identifier
			attr_accessor :device_type
			attr_accessor :source_event
			attr_accessor :profile_id
			attr_accessor :manufacturer_id


			def initialize(packet: nil)
				super

				if @parse_bytes
					@options = @parse_bytes.shift
					@source_address16 = Address16.new *@parse_bytes.shift(2)
					@source_address64 = Address64.new *@parse_bytes.shift(8)
					@identifier = @parse_bytes.shift 2
					@parent_address16 = Address16.new *@parse_bytes.shift(2)
					@device_type = @parse_bytes.shift
					@source_event = @parse_bytes.shift
					@profile_id = Bytes.unsigned_int_from_array @parse_bytes.shift(2)
					@manufacturer_id = Bytes.unsigned_int_from_array @parse_bytes.shift(2)
				end
			end
		end
	end
end
