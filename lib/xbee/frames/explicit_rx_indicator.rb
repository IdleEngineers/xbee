# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ExplicitRXIndicator < Frame
			api_id 0x91

			def initialize(packet: nil)
				# TODO: NOT IMPLEMENTED
				raise 'Type not implemented'
			end
		end
	end
end
