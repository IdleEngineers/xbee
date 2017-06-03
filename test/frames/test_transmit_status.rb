# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestTransmitStatus < Minitest::Test
	UUT = XBee::Frames::TransmitStatus


	def test_packet_parsing
		input = XBee::Packet.escape [0x7E, 0x00, 0x07, 0x8b, 0x01, 0x7d, 0x84, 0x00, 0x00, 0x01, 0x71]
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal 0x01, actual.id
		assert_equal XBee::Address16.new(0x7D, 0x84), actual.address16
		assert_equal 0x00, actual.retry_count
		assert_equal 0x00, actual.delivery_status
		assert_equal 0x01, actual.discovery_status
	end


	def test_bytes
		uut = UUT.new
		uut.id = 0xf1
		uut.address16 = XBee::Address16.new(0x12, 0x34)
		uut.retry_count = 0x56
		uut.delivery_status = 0x78
		uut.discovery_status = 0x9a

		expected = [0x8b, 0xf1, 0x12, 0x34, 0x56, 0x78, 0x9a]
		actual = uut.bytes
		assert_equal expected, actual
	end
end
