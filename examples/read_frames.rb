#!/usr/bin/env ruby

# frozen_string_literal: true
require 'bundler/setup'
require 'semantic_logger'
require 'trollop'

@options = Trollop.options do
	# opt :log_path, 'Path for log file', default: '/var/log/xbee/dump_packets.log', type: :string
	opt :log_level, 'Logging level - trace, debug, info, warn, error, fatal', default: 'trace', type: :string, callback: lambda { |s| raise Trollop::CommandlineError, 'Invalid logging level specified' unless SemanticLogger::LEVELS.include? s.to_sym}
end

SemanticLogger.default_level = @options.log_level.to_sym
# SemanticLogger.add_appender file_name: @options.log_path, formatter: :color
SemanticLogger.add_appender io: $stdout, formatter: :color


require 'xbee'

class ReadFrames
	include SemanticLogger::Loggable

	def run
		xbee = XBee::XBee.new device_path: '/dev/ttyUSB1', rate: 115200
		xbee.open
		loop do
			frame = xbee.read_frame
			logger.info 'Frame received.', frame: frame
		end
	end
end


ReadFrames.new.run if $0 == __FILE__
