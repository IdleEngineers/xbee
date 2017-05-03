# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class RemoteCommandRequest < Frame
			API_ID = 0x17
		end
	end
end
