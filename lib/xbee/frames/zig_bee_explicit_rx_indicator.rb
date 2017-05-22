# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ZigBeeExplicitRxIndicator < Frame
			api_id 0x91
		end
	end
end
