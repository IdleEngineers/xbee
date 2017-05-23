# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestATCommand < Minitest::Test
	def test_packet_parsing
		# Start delimiter: 7E
		# Length: 00 04 (4)
		# Frame type: 08 (AT Command)
		# AT Command: 4E 4A (NJ)
		# Checksum: 0D
		input = bytes             '7E 00 04 08 52 4E 4A 0D'
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of XBee::Frames::ATCommand, actual
		assert_equal 0x52, actual.id
		assert_equal [0x4e, 0x4a], actual.command_bytes
		# assert_equal 'NJ', actual.command
		assert_empty actual.parameter_bytes
	end
end
