# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ZigBeeTransmitRequest < Frame
			api_id 0x10
		end
	end
end
