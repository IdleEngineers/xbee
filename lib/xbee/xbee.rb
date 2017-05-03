# frozen_string_literal: true
require_relative 'packet'

module XBee
	# Either specify the port and serial parameters
	#
	#   xbee = XBee::Xbee.new port: '/dev/ttyUSB0', rate: 9600
	#
	# or pass in a SerialPort like object
	#
	#   xbee = XBee::XBee.new serial: some_serial_mockup_for_testing
	#
	class XBee
		def initialize(device_path: '/dev/ttyUSB0', rate: 115200, serial: nil)
			@device_path = device_path
			@rate = rate
			@serial = serial
			@connected = false
			@logger = nil
		end


		def open
			@serial ||= SerialPort.new @device_path, @rate
			@serial_input = Enumerator.new do |y|
				loop do
					y.yield @serial.readbyte
				end
			end
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


		def write_packet(packet)
			@serial.write packet.bytes_escaped.pack('C*').force_encoding('ascii')
			@serial.flush
		end


		def write_request(request)
			write_packet request.packet
			log { "Packet sent: #{request.packet.bytes.map { |b| b.to_s(16) }.join(',')}" }
		end


		def read_packet
			Packet.from_byte_enum(@serial_input).tap do |packet|
				log { "Packet received: #{packet.bytes.map { |b| b.to_s(16) }.join(',')}" }
			end
		end


		def read_frame
			Response.from_packet read_packet
		end


		def serial=(io)
			@serial = io
		end


		def logger=(logger)
			@logger = logger
		end


		def log
			@logger.call yield if @logger
		end
	end
end
