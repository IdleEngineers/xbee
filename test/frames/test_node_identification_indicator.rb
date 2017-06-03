# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestNodeIdentificationIndicator < Minitest::Test
	UUT = XBee::Frames::NodeIdentificationIndicator


	def test_packet_parsing
		input = XBee::Packet.escape bytes('7E 00 20 95 00 13 A2 00 40 52 2B AA 7D 84 02 7D 84 00 13 A2 00 40 52 2B AA 20 00 FF FE 01 01 C1 05 10 1E 1B')
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal [0x00, 0x13, 0xa2, 0x00, 0x40, 0x52, 0x2b, 0xaa], actual.address64.to_a
		assert_equal [0x7d, 0x84], actual.address16.to_a
		assert_equal 0x02, actual.options
		assert_equal [0x7d, 0x84], actual.source_address16.to_a
		assert_equal [0x00, 0x13, 0xa2, 0x00, 0x40, 0x52, 0x2b, 0xaa], actual.source_address64.to_a
		assert_equal [0x20, 0x00], actual.identifier
		assert_equal [0xff, 0xfe], actual.parent_address16.to_a
		assert_equal 0x01, actual.device_type
		assert_equal 0x01, actual.source_event
		assert_equal 0xc105, actual.profile_id
		assert_equal 0x101e, actual.manufacturer_id
	end
end
