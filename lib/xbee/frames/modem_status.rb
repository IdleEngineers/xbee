# frozen_string_literal: true
require_relative 'frame'
require_relative 'data/data_sample'

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

			attr_accessor :status_byte


			def initialize(packet: nil)
				@samples = []

				super

				if raw_data
					input = raw_data.dup
					@status_byte = input.shift
				end
			end


			def status_string
				if status < 0x80
					STATUSES[status]
				else
					'Ember ZigBee stack error'
				end
			end
		end
	end
end
