# frozen_string_literal: true
require 'comparable'

module XBee
	class Address
		include Comparable


		def <=>(other)
			to_a <=> other.to_a
		end


		def ==(other)
			to_a == other.to_a
		end
	end
end
