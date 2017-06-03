# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestRemoteATCommandRequest < Minitest::Test
	UUT = XBee::Frames::RemoteATCommandRequest


	def test_packet_parsing
		input = bytes '7E 00 10 17 01 00 13 A2 00 40 40 11 22 FF FE 02 42 48 01 F5'
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal 0x01, actual.id
		assert_equal XBee::Address64.new(0x00, 0x13, 0xA2, 0x00, 0x40, 0x40, 0x11, 0x22), actual.address64
		assert_equal XBee::Address16.new(0xFF, 0xFE), actual.address16
		assert_equal 0x02, actual.remote_command_options
		assert_equal [0x42, 0x48], actual.at_command
		assert_equal [0x01], actual.command_parameter
	end



	def test_bytes
		expected = XBee::Packet.unescape bytes('17 01 00 7D 33 A2 00 40 8B AC E4 FF FE 00 4E 49')
		uut = UUT.new
		uut.id = 1
		uut.address64 = XBee::Address64.from_string '00 13 A2 00 40 8B AC E4'
		uut.at_command = 'NI'
		actual = uut.bytes

		assert_equal expected, actual
	end
end
