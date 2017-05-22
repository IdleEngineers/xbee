# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestZigBeeIODataSampleRXIndicator < Minitest::Test
	def test_packet_parsing
		input = bytes             '7E 00 12 92 00 7D 33 A2 00 40 8B AC E4 0B F6 01 01 00 10 00 00 00 4A'
		# input = string_to_bytes '7E 00 12 92 00 13 A2 00 40 8B AC E4 0B F6 01 01 00 10 00 00 00 4A'
		# input = string_to_bytes '7E0012920013A200408BACE40BF6010100100000004A'
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of XBee::Frames::ZigBeeIODataSampleRxIndicator, actual
		assert_equal [0x00, 0x13, 0xa2, 0x00, 0x40, 0x8b, 0xac, 0xe4], actual.address64.to_a
		assert_equal [0x0b, 0xf6], actual.address16.to_a
		assert_equal 0x01, actual.receive_options
		assert_equal 0x01, actual.number_of_samples
		assert_equal 0x0010, actual.digital_channel_mask
		assert_equal 0x00, actual.analog_channel_mask
		assert_equal :low, actual.digital_channel_value(4)
	end
end
