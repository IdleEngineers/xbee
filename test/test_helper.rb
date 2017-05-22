require 'bundler/setup'
require 'pathname'
require 'simplecov'
require 'simplecov-rcov'

# Configure code coverage
unless SimpleCov.running
	SimpleCov.start do
		add_filter '/spec/'
		add_filter '/test/'
		add_filter '/vendor/'
		coverage_dir Pathname.new(__dir__).join('..', 'build', 'output', 'coverage')
	end
end


$LOAD_PATH.unshift Pathname.new(__dir__).join('..', 'lib')

# Configure minitest
require 'minitest'
require 'minitest/reporters'
require 'minitest/autorun'
Minitest::Reporters.use!

# # Test dependencies
require 'rr'

# require 'timecop'
# Timecop.safe_mode = true

require 'minitest/ci'
Minitest::Ci.clean = false
Minitest::Ci.report_dir = Pathname.new(__dir__).join('..', 'build', 'output', 'test')


module Minitest
	class Test
		# Helps testing by allowing XBee XCTU strings to be transformed into byte arrays on-the-fly.
		# @param string [String] The string to byte-ize, space-separated. Like '7E 00 12 92 00 7D 33 A2 00 40 8B AC E4 0B F6 01 01 00 10 00 00 00 4A'
		# @return [Array<Integer>] Array of bytes.
		def bytes(string)
			string.split(' ').map { |s| s.to_i(16) }
		end


		# Helps testing by allowing XBee XCTU strings to be transformed into byte arrays on-the-fly.
		# @param string [String] The string to byte-ize. Like '7E0012920013A200408BACE40BF6010100100000004A'
		# @return [Array<Integer>] Array of bytes.
		def string_to_bytes(string)
			string.chars.each_slice(2).to_a.map { |s| s.join('').to_i(16) }
		end
	end
end
