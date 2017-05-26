# frozen_string_literal: true
require_relative 'addressed_frame'

module XBee
	module Frames
		class TransmitRequest < AddressedFrame
			api_id 0x10

			attr_accessor :options
			attr_accessor :data

			def initialize(packet: nil)
				super

				if @parse_bytes
					@options = @parse_bytes.shift
					@data = @parse_bytes
					@parse_bytes = []
				end
			end
		end
	end
end
