# frozen_string_literal: true
require_relative 'frame'

module XBee
	module Frames
		class ModemStatus < Frame
			api_id 0x8A


			STATUSES = {
				0x00 => 'Hardware reset',
				0x01 => 'Watchdog timer reset',
				0x02 => 'Joined network',
				0x03 => 'Disassociated',
				0x06 => 'Coordinator started',
				0x07 => 'Network security key was updated',
				0x0D => 'Voltage supply limit exceeded',
				0x11 => 'Modem configuration changed while join in progress',
			}

			attr_accessor :status


			def initialize(packet: nil)
				super

				if @parse_bytes
					@status = @parse_bytes.shift
				end
			end


			def status_string
				if status < 0x80
					STATUSES[status]
				else
					'Ember ZigBee stack error'
				end
			end


			def bytes
				super + [status || 0x00]
			end
		end
	end
end
