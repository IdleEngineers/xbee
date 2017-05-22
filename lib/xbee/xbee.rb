# frozen_string_literal: true
require 'semantic_logger'
require_relative 'packet'

module XBee
	# Either specify the port and serial parameters
	#
	#   xbee = XBee::Xbee.new device_path: '/dev/ttyUSB0', rate: 9600
	#
	# or pass in a SerialPort like object
	#
	#   xbee = XBee::XBee.new io: some_serial_mockup_for_testing
	#
	class XBee
		include SemanticLogger::Loggable

		def initialize(device_path: '/dev/ttyUSB0', rate: 115200, io: nil)
			@device_path = device_path
			@rate = rate
			@io = io
			@connected = false
			@logger = nil
		end


		def open
			@io ||= SerialPort.new @device_path, @rate
			@io_input = Enumerator.new do |y|
				loop do
					y.yield @io.readbyte
				end
			end
			@connected = true
		end


		def close
			@io.close if @io
			@connected = false
		end


		def connected?
			@connected
		end
		alias :open? :connected?


		def write_packet(packet)
			@io.write packet.bytes_escaped.pack('C*').force_encoding('ascii')
			@io.flush
		end


		def write_request(request)
			logger.measure_trace('Packet sent.', payload: { bytes: request.packet.bytes }) do
				write_packet request.packet
			end
		end


		def read_packet
			Packet.from_byte_enum(@io_input).tap do |packet|
				logger.trace 'Packet received.', bytes: packet.bytes
			end
		end


		def read_frame
			Response.from_packet read_packet
		end


		def io=(io)
			@io = io
		end
	end
end
