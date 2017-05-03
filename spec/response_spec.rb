# frozen_string_literal: true
require_relative 'spec_helper'

module XBee
	describe Response do
		describe 'raises an error if an unknown packet should be decoded' do
			specify { expect { Response.from_packet(Packet.new [0x00, 0x1, 0x02, 0x03]) }.to raise_error IOError }
		end
	end
end
