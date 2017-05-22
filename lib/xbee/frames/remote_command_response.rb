# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class RemoteCommandResponse < Frame
			api_id 0x97
		end
	end
end
