# frozen_string_literal: true

require 'rspec/mocks/standalone'
require_relative '../lib/xbee'

serial = double('SerialPort').as_null_object
xbee = XBee::XBee.new device_path: '/dev/ttyS0', rate: 57600
xbee.serial = serial
xbee.open
num_reads = 0
start_time = Time.now.to_f
end_time = start_time + 10
puts 'Reading responses from a faked serial connection for 10 seconds'
while Time.now.to_f < end_time
	expect(serial).to receive(:readbyte).and_return(0x7e, 0x00, 0x07, 0x8b, 0x02, 0x79, 0x38, 0x00, 0x00, 0x00, 0xc1)
	xbee.read_frame
	num_reads += 1
end
puts 'Done'
puts "#{num_reads / 10.0} per second"
