# frozen_string_literal: true
require_relative 'address'

module XBee
	class Address16 < Address
		def initialize(msb, lsb)
			@bytes = [msb, lsb]
		end


		class << self
			def from_string(string)
				if (matcher = /^(\h\h)[^\h]*(\h\h)$/.match(string))
					new *(matcher[1..2].map &:hex)
				else
					raise ArgumentError, "#{string} is not a valid 16-bit address string"
				end
			end


			def from_array(array)
				if array.length == 2 && array.all? { |x| (0..255).cover? x }
					new *array
				else
					raise ArgumentError, "#{array.inspect} is not a valid 16-bit address array"
				end
			end
		end


		def to_s
			'%02x%02x' % @bytes
		end


		BROADCAST = new(0xff, 0xfe).freeze
		COORDINATOR = new(0x00, 0x00).freeze
	end
end
