XBee
====

A Ruby API for XBee ZigBee-RF-Modules
-------------------------------------

This gem is forked from the original XBee-Ruby gem. Because major API changes are being made a new name is appropriate.

Example: Transmit a packet to another node
------------------------------------------

	xbee = XBee::XBee.new port: '/dev/ttyUSB0', rate: 115200
	xbee.open
	request = XBeeRuby::TxRequest.new  XBeeRuby::Address64.new(0x00, 0x13, 0xa2, 0x00, 0x40, 0x4a, 0x50, 0x0c), [0x12, 0x34, 0x56]
	xbee.write_request request
	puts xbee.read_response
	xbee.close

Example: Receive packets
------------------------

	xbee = XBee::XBee.new port: '/dev/ttyUSB0', rate: 115200
	xbee.open
	while true do
		response = xbee.read_frame # blocking, returns an instance of XBee::Frames::Frame 
		case response
			when XBee::Frames::RxResponse
				puts "Received from #{response.address64}: #{response.data}"
			else
				puts "Other response: #{response}"
		end
	end

License
-------

The XBee code is licensed under the the MIT License

You find the license in the attached LICENSE.txt file
