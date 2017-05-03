# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class XBeeSensorReadIndicator < Frame
			API_ID = 0x94
		end
	end
end
