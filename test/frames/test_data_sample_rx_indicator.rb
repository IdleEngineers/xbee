# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestDataSampleRXIndicator < Minitest::Test
	UUT = XBee::Frames::DataSampleRXIndicator


	def test_packet_parsing
		input = XBee::Packet.escape bytes('7E 00 14 92 00 13 A2 00 40 52 2B AA 7D 84 01 01 00 1C 02 00 14 02 25 F5')
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal [0x00, 0x13, 0xa2, 0x00, 0x40, 0x52, 0x2b, 0xaa], actual.address64.to_a
		assert_equal [0x7d, 0x84], actual.address16.to_a
		assert_equal 0x01, actual.options
		assert_equal 0x01, actual.samples.length
		s = actual.samples.first
		assert_equal [:AD1], s.analog_values.keys
		assert_equal [:DIO2, :DIO3, :DIO4], s.digital_values.keys
		assert_equal 1, s.digital_values[:DIO2]
		assert_equal 0, s.digital_values[:DIO3]
		assert_equal 1, s.digital_values[:DIO4]
		assert_equal 549, s.analog_values[:AD1]
	end
end
