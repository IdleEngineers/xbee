XBee
====

A Ruby API for XBee ZigBee-RF-Modules
-------------------------------------

This gem is forked from the original XBee-Ruby gem. Because major API changes are being made a new name is appropriate.

See the `examples/` directory for some working examples with slightly more complexity than the samples below.

The `spec/` directory is left over from the forked gem, and will be converted to Minitest in the near future.

Example: Transmit a packet to another node
------------------------------------------

	xbee = XBee::XBee.new device_path: '/dev/ttyUSB0', rate: 115200
	xbee.open
	request = XBee::Frames::RemoteATCommandRequest.new
	request.address64 = XBee::Address64.from_string '0013A232408BACE4'
	request.at_command = 'NI'
	request.id = 0x01
	xbee.write_frame request
	puts xbee.read_frame
	xbee.close

Example: Receive packets
------------------------

	xbee = XBee::XBee.new port: '/dev/ttyUSB0', rate: 115200
	xbee.open
	loop do
		frame = xbee.read_frame
		puts "Frame received: #{frame.inspect}"
	end

Contributing
------------
All development happens via Git using the [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model. The canonical source location is
[XBee Bitbucket](https://work.techtonium.com/bitbucket/projects/XBEE). This repository is automatically mirrored to [GitHub](https://github.com/IdleEngineers/xbee).

If you find a bug or have a feature request, please create an issue in the [XBee issue tracker](https://work.techtonium.com/jira/browse/XBEE).


License
-------

The XBee code is licensed under the the MIT License

You find the license in the attached LICENSE.txt file
