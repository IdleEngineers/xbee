# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestExplicitAddressingCommand < Minitest::Test
	UUT = XBee::Frames::ExplicitAddressingCommand


	def test_packet_parsing
		input = [0x7E, 0x00, 0x1A, 0x11, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFE, 0xA0, 0xA1, 0x15, 0x54, 0xC1, 0x05, 0x00, 0x00, 0x54, 0x78, 0x44, 0x61, 0x74, 0x61, 0x3A]
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal 0x01, actual.id
		assert_equal XBee::Address64.new(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00), actual.address64
		assert_equal XBee::Address16.new(0xFF, 0xFE), actual.address16
		assert_equal 0xA0, actual.source_endpoint
		assert_equal 0xA1, actual.destination_endpoint
		assert_equal [0x15, 0x54], actual.cluster_id
		assert_equal [0xC1, 0x05], actual.profile_id
		assert_equal 0x00, actual.broadcast_radius
		assert_equal 0x00, actual.transmission_options
		assert_equal [0x54, 0x78, 0x44, 0x61, 0x74, 0x61], actual.data
	end
end
