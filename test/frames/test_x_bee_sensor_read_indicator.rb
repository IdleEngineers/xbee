# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestXBeeSensorReadIndicator < Minitest::Test
	UUT = XBee::Frames::XBeeSensorReadIndicator


	def test_packet_parsing
		input = XBee::Packet.escape bytes('7E 00 17 94 00 13 A2 00 40 52 2B AA DD 6C 01 03 00 02 00 CE 00 EA 00 52 01 6A 8B')
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal [0x00, 0x13, 0xa2, 0x00, 0x40, 0x52, 0x2b, 0xaa], actual.address64.to_a
		assert_equal [0xdd, 0x6c], actual.address16.to_a
		assert_equal 0x01, actual.options
		assert_equal 0x03, actual.one_wire_sensors
		assert_equal 0x0002, actual.analog_values[0]
		assert_equal 0x00CE, actual.analog_values[1]
		assert_equal 0x00EA, actual.analog_values[2]
		assert_equal 0x0052, actual.analog_values[3]
		assert_equal 0x016A, actual.temperature
	end
end
