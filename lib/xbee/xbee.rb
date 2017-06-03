# frozen_string_literal: true
require 'semantic_logger'

require_relative 'packet'
require_relative 'frames/at_command'
require_relative 'frames/at_command_queue_parameter_value'
require_relative 'frames/at_command_response'
require_relative 'frames/create_source_route'
require_relative 'frames/data_sample_rx_indicator'
require_relative 'frames/explicit_addressing_command'
require_relative 'frames/explicit_rx_indicator'
require_relative 'frames/many_to_one_route_request_indicator'
require_relative 'frames/modem_status'
require_relative 'frames/node_identification_indicator'
require_relative 'frames/over_the_air_firmware_update_status'
require_relative 'frames/receive_packet'
require_relative 'frames/remote_at_command_request'
require_relative 'frames/remote_at_command_response'
require_relative 'frames/route_record_indicator'
require_relative 'frames/transmit_request'
require_relative 'frames/transmit_status'
require_relative 'frames/xbee_sensor_read_indicator'


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


		def write_frame(frame)
			if frame.packet
				# TODO: Is it right to assume the packet is in sync with the frame?
				write_packet frame.packet
			else
				packet = frame.to_packet
				write_packet packet
			end
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
			Frames::Frame.from_packet read_packet
		end


		def io=(io)
			@io = io
		end
	end
end
