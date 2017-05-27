# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestATCommandResponse < Minitest::Test
	UUT = XBee::Frames::ATCommandResponse


	def test_packet_parsing
		input = bytes '7E 00 05 88 01 42 44 00 F0'
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal 0x01, actual.id
		assert_equal [0x42, 0x44], actual.command
		assert_equal 0x00, actual.status
		assert_empty actual.data
	end


	def test_bytes
		uut = UUT.new
		uut.id = 0x01
		uut.command = [0x42, 0x44]

		expected = bytes '88 01 42 44 00'
		actual = uut.bytes
		assert_equal expected, actual
	end
end
