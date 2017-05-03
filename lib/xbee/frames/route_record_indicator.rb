# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class RouteRecordIndicator < Frame
			API_ID = 0xA1
		end
	end
end
