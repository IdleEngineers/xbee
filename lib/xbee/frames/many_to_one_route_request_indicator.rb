# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ManyToOneRouteRequestIndicator < Frame
			api_id 0xA3
		end
	end
end
