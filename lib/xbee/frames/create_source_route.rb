# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class CreateSourceRoute < Frame
			API_ID = 0x21
		end
	end
end
