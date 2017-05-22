# frozen_string_literal: true
require_relative 'address'

module XBee
	class Address64 < Address
		def initialize(b1, b2, b3, b4, b5, b6, b7, b8)
			@bytes = [b1, b2, b3, b4, b5, b6, b7, b8]
		end


		class << self
			def from_string(string)
				if (matcher = /^(\h\h)[^\h]*(\h\h)[^\h]*(\h\h)[^\h]*(\h\h)[^\h]*(\h\h)[^\h]*(\h\h)[^\h]*(\h\h)[^\h]*(\h\h)$/.match(string))
					new *(matcher[1..8].map &:hex)
				else
					raise ArgumentError, "#{string.inspect} is not a valid 64-bit address string"
				end
			end


			def from_array(array)
				if array.length == 8 && array.all? { |x| (0..255).cover? x }
					new *array
				else
					raise ArgumentError, "#{array.inspect} is not a valid 64-bit address array"
				end
			end
		end


		def to_a
			@bytes
		end


		def to_s
			('%02x' * 8) % @bytes
		end


		BROADCAST = new 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff
		COORDINATOR = new 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	end
end
