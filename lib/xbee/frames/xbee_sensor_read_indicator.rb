# frozen_string_literal: true
require_relative 'frame'
require_relative '../bytes'

module XBee
	module Frames
		# When the device receives a sensor sample (from a Digi 1-wire sensor adapter), it is sent out the serial
		# port using this message type (when AO=0).
		class XBeeSensorReadIndicator < Frame
			api_id 0x94

			attr_accessor :address64
			attr_accessor :address16
			attr_accessor :options
			attr_accessor :one_wire_sensors
			attr_accessor :analog_values # Array of 4 integers
			attr_accessor :temperature


			def initialize(packet: nil)
				super

				if @parse_bytes
					@address64 = Address64.new *@parse_bytes.shift(8)
					@address16 = Address16.new *@parse_bytes.shift(2)
					@options = @parse_bytes.shift
					@one_wire_sensors = @parse_bytes.shift
					@analog_values = [
						Bytes.unsigned_int_from_array(@parse_bytes.shift(2)),
						Bytes.unsigned_int_from_array(@parse_bytes.shift(2)),
						Bytes.unsigned_int_from_array(@parse_bytes.shift(2)),
						Bytes.unsigned_int_from_array(@parse_bytes.shift(2)),
					]
					@temperature = Bytes.unsigned_int_from_array(@parse_bytes.shift(2))
				end
			end


			def bytes
				super +
					(address64 || Address64::COORDINATOR).to_a +
					(address16 || Address16::COORDINATOR).to_a +
					[options || 0x00] +
					[one_wire_sensors || 0x00] +
					((analog_values || [0xffff] * 4).map { |v| Bytes.array_from_unsigned_int(v, 2) }.reduce(:+))+
					Bytes.array_from_unsigned_int(temperature || 0x0, 2)
			end
		end
	end
end
