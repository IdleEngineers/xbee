# frozen_string_literal: true

module XBee
	class Response
		class << self
			@response_types = {}

			def frame_type type
				@response_types[type] = self
			end


			def from_packet packet
				@response_types[packet.data[0]].new packet.data rescue raise IOError, "Unknown response type 0x#{packet.data[0].to_s 16}"
			end
		end


		def to_s
			'Response'
		end
	end
end
