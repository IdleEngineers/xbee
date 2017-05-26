# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestATCommand < Minitest::Test
	UUT = XBee::Frames::ATCommand

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


	def test_bytes
		uut = UUT.new
		uut.id = 0x11
		uut.command_bytes = [0x44, 0x55]
		uut.parameter_bytes = [0x66, 0x67, 0x68]

		actual = uut.bytes
		assert_equal [0x08, 0x11, 0x44, 0x55, 0x66, 0x67, 0x68], actual
	end
end
