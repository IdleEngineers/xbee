# frozen_string_literal: true
require_relative 'identified_frame'

module XBee
	module Frames
		class ATCommandResponse < IdentifiedFrame
			api_id 0x88


			attr_accessor :at_command
			attr_accessor :status
			attr_accessor :data


			def initialize(packet: nil)
				super

				if @parse_bytes
					@at_command = @parse_bytes.shift 2
					@status = @parse_bytes.shift
					@data = @parse_bytes
					@parse_bytes = []
				end
			end


			def bytes
				super + (at_command || [0x00] * 2) + [status || 0x00] + (data || [])
			end
		end
	end
end
