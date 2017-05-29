# frozen_string_literal: true
require_relative 'unidentified_addressed_frame'

module XBee
	module Frames
		class ManyToOneRouteRequestIndicator < UnidentifiedAddressedFrame
			api_id 0xA3

		end
	end
end
