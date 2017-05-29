# frozen_string_literal: true

module XBee
	module Frames
		module Data
			class Sample
				# Bit-mapping of digital channel names
				DIGITAL_CHANNELS = [
					:na,
					:na,
					:na,
					:DIO12,
					:DIO11,
					:DIO10,
					:na,
					:na,
					:DIO7,
					:DIO6,
					:DIO5,
					:DIO4,
					:DIO3,
					:DIO2,
					:DIO1,
					:DIO0,
				]

				# Bit-mapping of analog channel names
				ANALOG_CHANNELS = [
					:supply_voltage,
					:na,
					:na,
					:na,
					:AD3,
					:AD2,
					:AD1,
					:AD0,
				]


				attr_reader :digital_values
				attr_reader :analog_values


				# Parses the input bytes into @digital_values and @analog_values.
				# Consumes the bytes read, so the next sample can be constructed.
				# @param parse_bytes [Array<Integer>] Input data.
				def initialize(parse_bytes:)
					input = parse_bytes
					@digital_channel_mask = (input.shift << 8) + input.shift
					@analog_channel_mask = input.shift

					@digital_values = {}
					if @digital_channel_mask > 0
						raw = (input.shift << 8) + input.shift
						DIGITAL_CHANNELS.reverse.each_with_index do |channel, index|
							if (@digital_channel_mask & (1 << index)) > 0
								@digital_values[channel] = (raw & (1 << index)) > 0 ? 1 : 0
							end
						end
					end

					@analog_values = {}
					ANALOG_CHANNELS.reverse.each_with_index do |channel, index|
						if (@analog_channel_mask & (1 << index)) > 0
							@analog_values[channel] = (input.shift << 8) + input.shift
						end
					end
				end
			end
		end
	end
end
