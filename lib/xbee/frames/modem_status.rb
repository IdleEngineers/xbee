# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ModemStatus < Frame
			API_ID = 0x8A
		end
	end
end
