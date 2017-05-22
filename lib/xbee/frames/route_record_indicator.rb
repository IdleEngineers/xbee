# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class RouteRecordIndicator < Frame
			api_id 0xA1
		end
	end
end
