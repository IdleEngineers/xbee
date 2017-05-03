# frozen_string_literal: true
require_relative '../exceptions/unknown_frame_type'
require_relative '../address_16'
require_relative '../address_64'

module XBee
	module Frames
		class Frame

			class << self
				# [<Integer, Frame>] Map of frame type IDs to implementation classes
				@frame_types = {}

				# Registers the frame type
				def api_id(byte)
					@frame_types[byte] = self
				end


				def from_packet(packet)
					raise Exceptions::UnknownFrameType, packet unless @frame_ids.has_key? packet.data[0]
					@frame_types[packet.data[0]].new packet.data
				end
			end


			attr_reader :address16
			attr_reader :address64
			attr_reader :data
			attr_reader :checksum


			def initialize(bytes)
				raise Exceptions::FrameFormatError, 'Invalid start delimiter' unless bytes[0] == 0x7E

				@address64 = Address64.new *bytes[1..8]
				@address16 = Address16.new *bytes[9..10]
				@length =
				@receive_options = bytes[11]
				@data = bytes[12..-1]
			end
		end
	end
end
