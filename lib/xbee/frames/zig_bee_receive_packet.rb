# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ZigBeeReceivePacket < Frame
			API_ID = 0x90
		end
	end
end
