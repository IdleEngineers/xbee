# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestRouteRecordIndicator < Minitest::Test
	UUT = XBee::Frames::RouteRecordIndicator


	def test_packet_parsing
		input = XBee::Packet.escape bytes('7E 00 13 A1 00 13 A2 00 40 40 11 22 33 44 01 03 EE FF CC DD AA BB 80')
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal XBee::Address64.new(0x00, 0x13, 0xa2, 0x00, 0x40, 0x40, 0x11, 0x22), actual.address64
		assert_equal XBee::Address16.new(0x33, 0x44), actual.address16
		assert_equal 0x01, actual.options
		assert_equal 3, actual.addresses.length
		assert_equal XBee::Address16.new(0xee, 0xff), actual.addresses[0]
		assert_equal XBee::Address16.new(0xcc, 0xdd), actual.addresses[1]
		assert_equal XBee::Address16.new(0xaa, 0xbb), actual.addresses[2]
	end
end
