# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ModemStatus < Frame
			api_id 0x8A
		end
	end
end
