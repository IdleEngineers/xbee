# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ATCommandResponse < Frame
			API_ID = 0x88
		end
	end
end
