# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestModemStatus < Minitest::Test
	UUT = XBee::Frames::ModemStatus


	def test_packet_parsing
		input = bytes '7E 00 02 8A 06 6F'
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal 0x06, actual.status
	end


	def test_bytes
		uut = UUT.new
		uut.status = 0x06

		actual = uut.bytes
		assert_equal [0x8a, 0x06], actual
	end
end
