# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ExtendedModemStatus < Frame
			API_ID = 0x98
		end
	end
end
