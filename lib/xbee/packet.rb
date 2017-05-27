# frozen_string_literal: true

module XBee
	class Packet
		START_BYTE = 0x7E
		ESCAPE = 0x7D
		XON = 0x11
		XOFF = 0x13

		ESCAPE_XOR = 0x20

		ESCAPE_BYTES = [
			START_BYTE, ESCAPE, XON, XOFF
		].freeze

		class << self
			# @param byte [Integer]
			def special_byte?(byte)
				ESCAPE_BYTES.include? byte
			end


			def checksum(bytes)
				255 - bytes.reduce(&:+) % 256
			end


			# Escapes an array of bytes. Ignores the first byte unless ignore_first_byte is set to false in the options hash.
			# @param bytes [Array<Integer>] The array of bytes to escape.
			# @param options [Hash] Options hash.
			# @option options [Boolean] :ignore_first_byte If the first byte should be ignored (usually true for handling an entire packet since the first byte is START_BYTE). Default true.
			# @return [Array<Integer>] Escaped bytes.
			def escape(bytes, options = {})
				ignore_first_byte = options.fetch :ignore_first_byte, true

				prepend = []
				if ignore_first_byte
					bytes = bytes.dup
					prepend = [bytes.shift]
				end

				prepend + bytes.reduce([]) do |escaped, b|
					if ESCAPE_BYTES.include?(b)
						escaped << ESCAPE
						escaped << (ESCAPE_XOR ^ b)
					else
						escaped << b
					end
				end
			end


			def unescape(bytes)
				bytes.reduce([]) do |unescaped, b|
					if unescaped.last == ESCAPE
						unescaped.pop
						unescaped << (0x20 ^ b)
					else
						unescaped << b
					end
				end
			end


			def from_bytes(bytes)
				if bytes.length < 4
					raise ArgumentError, "Packet is too short (only #{bytes.length} bytes)"
				end
				if bytes[0] != START_BYTE
					raise ArgumentError, 'Missing start byte'
				end
				data = [START_BYTE] + unescape(bytes[1..-1])
				length = (data[1] << 8) + data[2]
				if length != data.length - 4
					raise ArgumentError, "Expected data length to be #{length} but was #{data.length - 4}"
				end
				crc = checksum(data[3..-2])
				if crc != data[-1]
					raise ArgumentError, "Expected checksum to be 0x#{crc.to_s 16} but was 0x#{data[-1].to_s 16}"
				end
				new data[3..-2]
			end


			def next_unescaped_byte(bytes)
				byte = bytes.next
				if byte == ESCAPE
					0x20 ^ bytes.next
				else
					byte
				end
			end


			def from_byte_enum(bytes)
				begin
					loop until bytes.next == START_BYTE
					length = (next_unescaped_byte(bytes) << 8) + next_unescaped_byte(bytes)
				rescue
					raise IOError, 'Packet is too short, unable to read length fields.'
				end
				begin
					data = (1..length).map { next_unescaped_byte bytes }
				rescue
					raise IOError, "Expected data length to be #{length} but got fewer bytes"
				end
				begin
					crc = next_unescaped_byte bytes
				rescue
					raise IOError, 'Packet is too short, unable to read checksum'
				end
				if crc != checksum(data)
					raise IOError, "Expected checksum to be 0x#{checksum(data).to_s 16} but was 0x#{crc.to_s 16}"
				end
				new data
			end
		end


		# @param data [Array<Integer>] Byte array
		def initialize(data)
			@data = data
		end


		def data
			@data
		end


		def length
			@data.length
		end


		def checksum
			Packet.checksum @data
		end


		def bytes
			[START_BYTE, length >> 8, length & 0xff] + @data + [checksum]
		end


		def bytes_escaped
			[START_BYTE] + bytes[1..-1].flat_map do |b|
				if self.class.special_byte?(b)
					[ESCAPE, 0x20 ^ b]
				else
					b
				end
			end
		end


		def ==(other)
			data == other.data
		end


		def to_s
			'Packet [' + data.map { |b| "0x#{b.to_s 16}" }.join(', ') + ']'
		end
	end
end
