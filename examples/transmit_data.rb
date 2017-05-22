# frozen_string_literal: true

require_relative '../lib/xbee'

xbee = XBee::XBee.new device_path: '/dev/ttyUSB0', rate: 57600
xbee.open
request = XBee::TxRequest.new  XBee::Address64.new(0x00, 0x13, 0xa2, 0x00, 0x40, 0x4a, 0x50, 0x0c), [0x05, 0x00, 0x06]
xbee.write_request request
puts xbee.read_response
xbee.close
