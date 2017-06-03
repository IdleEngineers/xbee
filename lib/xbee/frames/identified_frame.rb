# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		# The base class for frames that have an ID for tracking the radio's processing.
		class IdentifiedFrame < Frame
			attr_accessor :id

			def initialize(packet: nil)
				super

				if @parse_bytes
					@id = @parse_bytes.shift
				end
			end


			def bytes
				super + [(id || 0x00)]
			end
		end
	end
end
