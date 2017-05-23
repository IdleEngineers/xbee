# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestTransmitRequest < Minitest::Test
	def test_packet_parsing
		input = [0x7E, 0x00, 0x16, 0x10, 0x01, 0x00, 0x7D, 0x33, 0xA2, 0x00, 0x40, 0x0A, 0x01, 0x27, 0xFF, 0xFE, 0x00, 0x00, 0x54, 0x78, 0x44, 0x61, 0x74, 0x61, 0x30, 0x41, 0x7D, 0x33]

		# input = bytes '7E 00 16 10 01 00 7D 33 A2 00 40 0A 01 27 FF FE 00 00 54 78 44 61 74 61 30 41 7D 33'
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of XBee::Frames::TransmitRequest, actual
		assert_equal 0x01, actual.id
		assert_equal XBee::Address64.new(0x00, 0x13, 0xA2, 0x00, 0x40, 0x0A, 0x01, 0x27), actual.address64
		assert_equal XBee::Address16.new(0xFF, 0xFE), actual.address16
		assert_equal 0x00, actual.broadcast_radius
		assert_equal 0x00, actual.options
		assert_equal 'TxData0A'.bytes, actual.data
	end
end
