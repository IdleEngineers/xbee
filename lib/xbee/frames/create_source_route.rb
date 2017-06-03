# frozen_string_literal: true
require_relative 'addressed_frame'

module XBee
	module Frames
		class CreateSourceRoute < AddressedFrame
			api_id 0x21

			# TODO: Not implemented
			def initialize(packet: nil)
				raise 'Not implemented'
			end
		end
	end
end
