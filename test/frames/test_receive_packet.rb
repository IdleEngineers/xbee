# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestReceivePacket < Minitest::Test
	UUT = XBee::Frames::ReceivePacket


	def test_packet_parsing
		input = XBee::Packet.escape bytes('7E 00 12 90 00 13 A2 00 40 52 2B AA 7D 84 01 52 78 44 61 74 61 0D')
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal XBee::Address64.new(0x00, 0x13, 0xA2, 0x00, 0x40, 0x52, 0x2B, 0xAA), actual.address64
		assert_equal XBee::Address16.new(0x7D, 0x84), actual.address16
		assert_equal 0x01, actual.options
		assert_equal [0x52, 0x78, 0x44, 0x61, 0x74, 0x61], actual.data
	end


	def test_bytes
		uut = UUT.new
		uut.address64 = XBee::Address64.new(0x00, 0x13, 0xA2, 0x00, 0x40, 0x52, 0x2B, 0xAA)
		uut.address16 = XBee::Address16.new(0x7D, 0x84)
		uut.options = 0x01
		uut.data = [0x52, 0x78, 0x44, 0x61, 0x74, 0x61]

		actual = uut.bytes
		assert_equal bytes('90 00 13 A2 00 40 52 2B AA 7D 84 01 52 78 44 61 74 61'), actual
	end
end
