# frozen_string_literal: true

module XBee
	class Address
		def to_a
			raise 'Override to return the address as a byte array'
		end
	end
end
