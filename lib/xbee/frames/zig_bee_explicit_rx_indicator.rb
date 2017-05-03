# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ZigBeeExplicitRxIndicator < Frame
			API_ID = 0x91
		end
	end
end
