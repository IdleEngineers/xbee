# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ATCommandResponse < Frame
			api_id 0x88
		end
	end
end
