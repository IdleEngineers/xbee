# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ExtendedModemStatus < Frame
			api_id 0x98
		end
	end
end
