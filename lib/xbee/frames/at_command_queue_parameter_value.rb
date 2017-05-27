# frozen_string_literal: true
require_relative 'at_command'

module XBee
	module Frames
		# This frame allows you to query or set device parameters. In contrast to the AT Command (0x08)
		# frame, this frame queues new parameter values and does not apply them until you issue either:
		#  * The AT Command (0x08) frame (for API type)
		#  * The AC command
		#
		# When querying parameter values, the 0x09 frame behaves identically to the 0x08 frame. The device
		# returns register queries immediately and not does not queue them. The response for this command is
		# also an AT Command Response frame (0x88).
		#
		# Send a command to change the baud rate (BD) to 115200 baud, but do not apply changes yet. The
		# module continues to operate at the previous baud rate until you apply the changes.
		class ATCommandQueueParameterValue < ATCommand
			api_id 0x09
		end
	end
end
