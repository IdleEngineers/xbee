# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ZigBeeTransmitStatus < Frame
			API_ID = 0x8B
		end
	end
end
