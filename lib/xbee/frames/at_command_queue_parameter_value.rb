# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ATCommandQueueParameterValue < Frame
			API_ID = 0x09
		end
	end
end
