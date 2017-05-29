# frozen_string_literal: true
require_relative 'unidentified_addressed_frame'

module XBee
	module Frames
		class OverTheAirFirmwareUpdateStatus < UnidentifiedAddressedFrame
			api_id 0xA0

			attr_accessor :options
			attr_accessor :bootloader_message
			attr_accessor :block_number

			attr_accessor :target_address64


			def initialize(packet: nil)
				super

				if @parse_bytes
					@options = @parse_bytes.shift
					@bootloader_message = @parse_bytes.shift
					@block_number = @parse_bytes.shift
					@target_address64 = Address64.new *@parse_bytes.shift(8)
				end
			end
		end
	end
end
