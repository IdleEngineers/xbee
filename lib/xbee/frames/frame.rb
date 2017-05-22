# frozen_string_literal: true
require 'semantic_logger'

require_relative '../address_16'
require_relative '../address_64'
require_relative '../exceptions/frame_format_error'
require_relative '../exceptions/unknown_frame_type'

module XBee
	module Frames
		class Frame
			include SemanticLogger::Loggable

			class << self
				# [<Integer, Frame>] Map of frame type IDs to implementation classes
				@@frame_types = {}

				# Registers the frame type
				def api_id(byte)
					@@frame_types ||= {}
					@@frame_types[byte] = self
				end


				def from_packet(packet)
					raise Exceptions::UnknownFrameType, packet unless @@frame_types.has_key? packet.data[0]
					@@frame_types[packet.data[0]].new packet: packet
				end
			end


			attr_reader :address16
			attr_reader :address64
			attr_reader :data

			# [XBee::Packet] if this frame was received, it'll belong to a Packet. (Frames prepped for transmit have no Packet association.)
			attr_reader :packet


			def initialize(packet: nil)
				logger.trace 'Initializing...', packet: packet

				if packet
					@packet = packet
					bytes = packet.data
					@address64 = Address64.new *bytes[1..8]
					@address16 = Address16.new *bytes[9..10]
					@receive_options = bytes[11]
					@data = bytes[12..-1]
				end
			end
		end
	end
end
