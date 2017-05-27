# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ReceivePacket < Frame
			api_id 0x90

			def initialize(packet: nil)
				# TODO: NOT IMPLEMENTED
				raise 'Type not implemented'
			end
		end
	end
end
