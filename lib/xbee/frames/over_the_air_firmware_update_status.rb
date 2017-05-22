# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class OverTheAirFirmwareUpdateStatus < Frame
			api_id 0xA0
		end
	end
end
