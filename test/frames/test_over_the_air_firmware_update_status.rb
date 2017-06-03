# frozen_string_literal: true
require_relative '../test_helper'
require 'xbee'

class TestOverTheAirFirmwareUpdateStatus < Minitest::Test
	UUT = XBee::Frames::OverTheAirFirmwareUpdateStatus


	def test_packet_parsing
		input = XBee::Packet.escape bytes('7E 00 16 A0 00 13 A2 00 40 3E 07 50 00 00 01 52 00 00 13 A2 00 40 52 2B AA 66')
		packet = XBee::Packet.from_bytes input
		actual = XBee::Frames::Frame.from_packet packet

		assert_instance_of UUT, actual
		assert_equal XBee::Address64.new(0x00, 0x13, 0xa2, 0x00, 0x40, 0x3e, 0x07, 0x50), actual.address64
		assert_equal XBee::Address16.new(0x0, 0x0), actual.address16
		assert_equal 0x01, actual.options
		assert_equal 0x52, actual.bootloader_message
		assert_equal 0x00, actual.block_number
		assert_equal XBee::Address64.new(0x00, 0x13, 0xa2, 0x00, 0x40, 0x52, 0x2b, 0xaa), actual.target_address64
	end
end
