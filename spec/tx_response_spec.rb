# frozen_string_literal: true
require_relative_relative 'spec_helper'

module XBee
	describe TxResponse do
		subject { TxResponse.new [0x8b, 0x1, 0xab, 0xcd, 0x02, 0x03, 0x04] }

		its(:frame_id) { should == 0x01 }
		its(:address16) { should == Address16.new(0xab, 0xcd) }
		its(:retry_count) { should == 0x02 }
		its(:delivery_status) { should == 0x03 }
		its(:discovery_status) { should == 0x04 }

		describe 'can be reconstructed from a packet' do
			it { should == Response.from_packet(Packet.new [0x8b, 0x1, 0xab, 0xcd, 0x02, 0x03, 0x04]) }
		end
	end
end
