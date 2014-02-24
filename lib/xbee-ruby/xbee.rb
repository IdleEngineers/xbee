=begin

This file is part of the xbee-ruby gem.

Copyright 2013 Dirk Grappendorf, www.grappendorf.net

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=end

require 'xbee-ruby/packet'

module XBeeRuby

	class XBee

		# Either specify the port and serial parameters
		#
		#   xbee = XBeeRuby::Xbee.new port: '/dev/ttyUSB0', rate: 9600
		#
		# or pass in a SerialPort like object
		#
		#   xbee = XBeeRuby::XBee.new serial: some_serial_mockup_for_testing
		#
		def initialize port: '/dev/ttyUSB0', rate: 9600, serial: nil
			@port = port
			@rate = rate
			@serial = serial
			@connected = false
			@logger = nil
		end

		def open
			@serial ||= SerialPort.new @port, @rate
			@serial_input = Enumerator.new { |y| loop do
				y.yield @serial.readbyte
			end }
			@connected = true
		end

		def close
			@serial.close if @serial
			@connected = false
		end

		def connected?
			@connected
		end

		alias :open? :connected?

		def write_packet packet
			@serial.write packet.bytes_escaped.pack('C*').force_encoding('ascii')
			@serial.flush
		end

		def write_request request
			write_packet request.packet
			log { "Packet sent: #{request.packet.bytes.map { |b| b.to_s(16) }.join(',')}" }
		end

		def read_packet
			Packet.from_byte_enum(@serial_input).tap do |packet|
				log { "Packet received: #{packet.bytes.map { |b| b.to_s(16) }.join(',')}" }
			end
		end

		def read_response
			Response.from_packet read_packet
		end

		def serial= io
			@serial = io
		end

		def logger= logger
			@logger = logger
		end

		def log
			@logger.call yield if @logger
		end
	end

end