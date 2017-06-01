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
					raise "Attempted to redefine API ID #{byte.inspect}" if @@frame_types.has_key? byte
					@@frame_types[byte] = self

					define_singleton_method(:frame_type) do
						byte
					end

					define_method(:frame_type) do
						byte
					end
				end


				def from_packet(packet)
					raise Exceptions::UnknownFrameType, packet unless @@frame_types.has_key? packet.data[0]
					@@frame_types[packet.data[0]].new packet: packet
				end
			end


			# [XBee::Packet] if this frame was received, it'll belong to a Packet. (Frames prepped for transmit have no Packet association.)
			attr_reader :packet

			# Subclasses should shift +@parse_bytes+ as necessary to get their data fields.
			def initialize(packet: nil)
				logger.trace 'Initializing...', packet: packet
				@packet = packet
				if packet
					@parse_bytes = packet.data.dup
					@frame_type = @parse_bytes.shift
				end
			end


			def bytes
				[frame_type]
			end


			def to_packet
				@packet = Packet.new bytes
			end
		end
	end
end
