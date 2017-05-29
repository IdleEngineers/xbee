# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestManyToOneRouteRequestIndicator < Minitest::Test
	UUT = XBee::Frames::ManyToOneRouteRequestIndicator


	def test_packet_parsing
		input = XBee::Packet.escape bytes('7E 00 0C A3 00 13 A2 00 40 40 11 22 00 00 00 F4')
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal XBee::Address64.new(0x00, 0x13, 0xa2, 0x00, 0x40, 0x40, 0x11, 0x22), actual.address64
		assert_equal XBee::Address16.new(0x00, 0x00), actual.address16
	end
end
