# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ZigBeeTransmitRequest < Frame
			API_ID = 0x10
		end
	end
end
