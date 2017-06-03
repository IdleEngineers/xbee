module XBee
	# Starting to accumulate code to manipulate arrays of bytes in one place. Maybe eventually this will be a subclass of Array or...?
	class Bytes

		class << self

			def array_from_unsigned_int(int, _num_bytes = 2)
				# TODO: Make this more generic than the 16-bit case
				[(int >> 8) & 0xff, int & 0xff]
			end


			def unsigned_int_from_array(array)
				index = -1
				array.reverse.reduce(0) do |result, byte|
					result + (byte << 8 * (index += 1))
				end
			end
		end
	end
end
