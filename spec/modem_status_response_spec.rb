# frozen_string_literal: true
require_relative 'spec_helper'

module XBee
	describe ModemStatusResponse do
		subject { ModemStatusResponse.new [0x8a, 0x12] }

		its(:modem_status) { should == 0x12 }

		describe 'can be reconstructed from a packet' do
			it { should == Response.from_packet(Packet.new [0x8a, 0x12]) }
		end
	end
end
