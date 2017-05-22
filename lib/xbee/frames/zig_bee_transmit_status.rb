# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ZigBeeTransmitStatus < Frame
			api_id 0x8B
		end
	end
end
