# frozen_string_literal: true

module XBee
	class Address
		include Comparable


		def <=>(other)
			to_a <=> other.to_a
		end


		def ==(other)
			to_a == other.to_a
		end


		def to_a
			@bytes
		end

	end
end
