# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ZigBeeReceivePacket < Frame
			api_id 0x90
		end
	end
end
