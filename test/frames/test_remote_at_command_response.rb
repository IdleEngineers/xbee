# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestRemoteATCommandResponse < Minitest::Test
	UUT = XBee::Frames::RemoteATCommandResponse


	def test_packet_parsing
		input = XBee::Packet.escape bytes('7E 00 13 97 55 00 13 A2 00 40 52 2B AA 7D 84 53 4C 00 40 52 2B AA F0')
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal XBee::Address64.new(0x00, 0x13, 0xa2, 0x00, 0x40, 0x52, 0x2b, 0xaa), actual.address64
		assert_equal XBee::Address16.new(0x7d, 0x84), actual.address16
		assert_equal [0x53, 0x4c], actual.at_command
		assert_equal 0x00, actual.status
		assert_equal [0x40, 0x52, 0x2b, 0xaa], actual.data
	end
end
