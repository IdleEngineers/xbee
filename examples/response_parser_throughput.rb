# frozen_string_literal: true

require_relative '../lib/xbee'

class FakeIO
	def initialize
		@queue = Queue.new
	end

	def readbyte
		if @queue.empty?
			load_queue
		end
		@queue.pop
	end

	def load_queue
		[0x7e, 0x00, 0x07, 0x8b, 0x02, 0x79, 0x38, 0x00, 0x00, 0x00, 0xc1].each do |b|
			@queue.push b
		end
	end
end

xbee = XBee::XBee.new io: FakeIO.new
xbee.open
num_reads = 0
start_time = Time.now.to_f
end_time = start_time + 10
puts 'Reading responses from a faked serial connection for 10 seconds'
while Time.now.to_f < end_time
	xbee.read_frame
	num_reads += 1
end
puts 'Done'
puts "#{num_reads / 10.0} per second"
