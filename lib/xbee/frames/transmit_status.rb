# frozen_string_literal: true
require_relative 'identified_frame'

module XBee
	module Frames
		class TransmitStatus < IdentifiedFrame
			api_id 0x8b


			attr_accessor :address16
			attr_accessor :transmit_retry_count
			attr_accessor :delivery_status
			attr_accessor :discovery_status


			DELIVERY_STATUSES = {
				0x00 => 'Success',
				0x01 => 'MAC ACK Failure',
				0x02 => 'CCA Failure',
				0x15 => 'Invalid destination endpoint',
				0x21 => 'Network ACK Failure',
				0x22 => 'Not Joined to Network',
				0x23 => 'Self-addressed',
				0x24 => 'Address Not Found',
				0x25 => 'Route Not Found',
				0x26 => 'Broadcast source failed to hear a neighbor relay the message',
				0x2B => 'Invalid binding table index',
				0x2C => 'Resource error lack of free buffers, timers, etc.',
				0x2D => 'Attempted broadcast with APS transmission',
				0x2E => 'Attempted unicast with APS transmission, but EE=0',
				0x32 => 'Resource error lack of free buffers, timers, etc.',
				0x74 => 'Data payload too large',
				0x75 => 'Indirect message unrequested',
			}.freeze

			DISCOVERY_STATUSES = {
				0x00 => 'No Discovery Overhead',
				0x01 => 'Address Discovery',
				0x02 => 'Route Discovery',
				0x03 => 'Address and Route',
				0x40 => 'Extended Timeout Discovery',
			}.freeze


			def initialize(packet: nil)
				super

				if @parse_bytes
					@address16 = Address16.new *@parse_bytes.shift(2)
					@transmit_retry_count = @parse_bytes.shift
					@delivery_status = @parse_bytes.shift
					@discovery_status = @parse_bytes.shift
				end
			end
		end
	end
end
