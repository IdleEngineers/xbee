#!/usr/bin/env ruby
# frozen_string_literal: true
require 'timeout'
require_relative '../lib/xbee'

class CheckAndSetDestinationAddress
	def run
		xbee = XBee::XBee.new device_path: '/dev/ttyUSB0', rate: 115200
		xbee.open

		# First get Identifier
		request = XBee::Frames::RemoteATCommandRequest.new
		request.address64 = XBee::Address64.from_string '0013A200408BACE4'
		request.at_command = 'NI'
		request.id = 0x01
		puts "Transmitting frame: #{request.inspect}"
		xbee.write_frame request
		Timeout.timeout(10) do
			loop do
				response = xbee.read_frame
				if response.is_a?(XBee::Frames::RemoteATCommandResponse)
					if response.address64 == request.address64
						@ni = response.data.pack('C*')
						puts format('Got node identity from %s: %s', request.address64.to_s, response.data.pack('C*'))
						break
					else
						puts format('Got response from wrong node %s: %s', request.address64.to_s, response.data.pack('C*'))
					end
				end
				puts "Got response we don't need: #{response}"
			end
		end


		# Now get destination address
		request = XBee::Frames::RemoteATCommandRequest.new
		request.address64 = XBee::Address64.from_string '0013A200408BACE4'
		request.at_command = 'DH'
		request.id = 0x02
		puts "Transmitting frame: #{request.inspect}"
		xbee.write_frame request
		Timeout.timeout(10) do
			loop do
				response = xbee.read_frame
				if response.is_a?(XBee::Frames::RemoteATCommandResponse)
					if response.address64 == request.address64
						puts format('Got DH from %s: %s', request.address64.to_s, response.data)
						@dh = response.data
						break
					else
						puts format('Got response from wrong node %s: %s', request.address64.to_s, response.data.pack('C*'))
					end
				end
				puts "Got response we don't need: #{response}"
			end
		end

		request = XBee::Frames::RemoteATCommandRequest.new
		request.address64 = XBee::Address64.from_string '0013A200408BACE4'
		request.at_command = 'DL'
		request.id = 0x03
		puts "Transmitting frame: #{request.inspect}"
		xbee.write_frame request
		Timeout.timeout(10) do
			loop do
				response = xbee.read_frame
				if response.is_a?(XBee::Frames::RemoteATCommandResponse)
					if response.address64 == request.address64
						puts format('Got DL from %s: %s', request.address64.to_s, response.data)
						@dl = response.data
						break
					else
						puts format('Got response from wrong node %s: %s', request.address64.to_s, response.data.pack('C*'))
					end
				end
				puts "Got response we don't need: #{response}"
			end
		end

		@dest = XBee::Address64.new *@dh, *@dl
		puts "Node #{@ni.inspect} Destination: #{@dest}"
		# @target = XBee::Address64::COORDINATOR
		@target = XBee::Address64.from_string '0013A20040B79952'

		unless @dest == @target
			puts "Updating destination address to be #{@target}..."
			request = XBee::Frames::RemoteATCommandRequest.new
			request.address64 = XBee::Address64.from_string '0013A200408BACE4'
			request.at_command = 'DH'
			request.command_parameter = @target.to_a[0..3]
			request.id = 0x04
			puts "Transmitting frame: #{request.inspect}"
			xbee.write_frame request
			Timeout.timeout(10) do
				loop do
					response = xbee.read_frame
					if response.is_a?(XBee::Frames::RemoteATCommandResponse)
						if response.address64 == request.address64
							puts format('Got DH from %s: %s', request.address64.to_s, response.data)
							@dl = response.data
							break
						else
							puts format('Got response from wrong node %s: %s', request.address64.to_s, response.data.pack('C*'))
						end
					end
					puts "Got response we don't need: #{response}"
				end
			end

			request = XBee::Frames::RemoteATCommandRequest.new
			request.address64 = XBee::Address64.from_string '0013A200408BACE4'
			request.at_command = 'DL'
			request.command_parameter = @target.to_a[4..7]
			request.id = 0x05
			puts "Transmitting frame: #{request.inspect}"
			xbee.write_frame request
			Timeout.timeout(10) do
				loop do
					response = xbee.read_frame
					if response.is_a?(XBee::Frames::RemoteATCommandResponse)
						if response.address64 == request.address64
							puts format('Got DL from %s: %s', request.address64.to_s, response.data)
							@dl = response.data
							break
						else
							puts format('Got response from wrong node %s: %s', request.address64.to_s, response.data.pack('C*'))
						end
					end
					puts "Got response we don't need: #{response}"
				end
			end

			request = XBee::Frames::RemoteATCommandRequest.new
			request.address64 = XBee::Address64.from_string '0013A200408BACE4'
			request.at_command = 'AC'
			request.id = 0x06
			puts "Transmitting frame: #{request.inspect}"
			xbee.write_frame request
			Timeout.timeout(10) do
				loop do
					response = xbee.read_frame
					if response.is_a?(XBee::Frames::RemoteATCommandResponse)
						if response.address64 == request.address64
							puts format('Got AC from %s: %s', request.address64.to_s, response.data)
							@dl = response.data
							break
						else
							puts format('Got response from wrong node %s: %s', request.address64.to_s, response.data.pack('C*'))
						end
					end
					puts "Got response we don't need: #{response}"
				end
			end
		end

	ensure
		xbee.close
	end
end

CheckAndSetDestinationAddress.new.run if $0 == __FILE__
