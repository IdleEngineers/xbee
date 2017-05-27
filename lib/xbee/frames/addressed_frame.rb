# frozen_string_literal: true
require_relative 'identified_frame'

module XBee
	module Frames
		class AddressedFrame < IdentifiedFrame

			attr_accessor :address16
			attr_accessor :address64
			attr_accessor :broadcast_radius


			def initialize(packet: nil)
				super

				if @parse_bytes
					@address64 = Address64.new *@parse_bytes.shift(8)
					@address16 = Address16.new *@parse_bytes.shift(2)
					@broadcast_radius = @parse_bytes.shift
				end
			end


			def bytes
				super + (address64 || Address64.from_array([0] * 8)).to_a + (address16 || Address16.new(0, 0)).to_a + [broadcast_radius || 0x00]
			end
		end
	end
end
