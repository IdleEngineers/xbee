#!/usr/bin/env ruby

# frozen_string_literal: true
require 'bundler/setup'
require 'semantic_logger'
require 'trollop'

@options = Trollop.options do
	opt :device, 'Path to serial device', default: '/dev/ttyUSB0', type: :string
	opt :baud, 'Baud rate for XBee radio', default: 115200, type: :integer
	opt :log_path, 'Path for log file', default: nil, type: :string
	opt :log_level, 'Logging level - trace, debug, info, warn, error, fatal', default: 'debug', type: :string, callback: lambda { |s| raise Trollop::CommandlineError, 'Invalid logging level specified' unless SemanticLogger::LEVELS.include? s.to_sym}
end

SemanticLogger.default_level = @options.log_level.to_sym
SemanticLogger.add_appender file_name: @options.log_path, formatter: :color if @options.log_path
SemanticLogger.add_appender io: $stdout, formatter: :color


require 'xbee'

class ReadFrames
	include SemanticLogger::Loggable


	def initialize(device_path: @options.device, rate: @options.baud)
		@device_path = device_path
		@rate = rate
	end


	def run
		xbee = XBee::XBee.new device_path: @device_path, rate: @rate
		xbee.open
		loop do
			frame = xbee.read_frame
			logger.info 'Frame received.', frame: frame
		end
	end
end

if $0 == __FILE__
	reader = ReadFrames.new device_path: @options.device, rate: @options.baud
	reader.run
end
