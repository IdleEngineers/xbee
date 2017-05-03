# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class OverTheAirFirmwareUpdateStatus < Frame
			API_ID = 0xA0
		end
	end
end
