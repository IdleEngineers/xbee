# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ZigBeeIODataSampleRxIndicator < Frame
			API_ID = 0x92
		end
	end
end
