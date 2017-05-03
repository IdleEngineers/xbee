# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class NodeIdentificationIndicator < Frame
			API_ID = 0x95
		end
	end
end
