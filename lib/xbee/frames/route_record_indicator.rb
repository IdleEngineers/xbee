# frozen_string_literal: true
require_relative 'unidentified_addressed_frame'

module XBee
	module Frames
		class RouteRecordIndicator <  UnidentifiedAddressedFrame
			api_id 0xA1

			attr_accessor :options
			attr_accessor :addresses


			def initialize(packet: nil)
				@addresses = []

				super

				if @parse_bytes
					@options = @parse_bytes.shift
					number_of_addresses = @parse_bytes.shift
					number_of_addresses.times do
						@addresses.push Address16.new(*@parse_bytes.shift(2))
					end
				end
			end
		end
	end
end
