# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ExplicitAddressingZigBeeCommandFrame < Frame
			API_ID = 0x11
		end
	end
end
