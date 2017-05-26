# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestATCommandQueueParameterValue < Minitest::Test
	UUT = XBee::Frames::ATCommandQueueParameterValue


	def test_packet_parsing
		input = bytes '7E 00 05 09 01 42 44 07 68'
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of XBee::Frames::ATCommandQueueParameterValue, actual
		assert_equal 0x01, actual.id
		assert_equal [0x42, 0x44], actual.command_bytes
		assert_equal [0x07], actual.parameter_bytes
	end


	def test_bytes
		uut = UUT.new
		uut.id = 0x11
		uut.command_bytes = [0x44, 0x55]
		uut.parameter_bytes = [0x66, 0x67, 0x68]

		actual = uut.bytes
		assert_equal [0x09, 0x11, 0x44, 0x55, 0x66, 0x67, 0x68], actual
	end
end
