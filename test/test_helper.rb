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


# Make sure helper methods work
class TestTestHelper < Minitest::Test
	def test_bytes
		input = '00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f 80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f 90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff'
		actual = bytes input
		expected = (0..255).to_a
		assert_equal expected, actual
	end


	def test_string_to_bytes
		input = '000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f303132333435363738393a3b3c3d3e3f404142434445464748494a4b4c4d4e4f505152535455565758595a5b5c5d5e5f606162636465666768696a6b6c6d6e6f707172737475767778797a7b7c7d7e7f808182838485868788898a8b8c8d8e8f909192939495969798999a9b9c9d9e9fa0a1a2a3a4a5a6a7a8a9aaabacadaeafb0b1b2b3b4b5b6b7b8b9babbbcbdbebfc0c1c2c3c4c5c6c7c8c9cacbcccdcecfd0d1d2d3d4d5d6d7d8d9dadbdcdddedfe0e1e2e3e4e5e6e7e8e9eaebecedeeeff0f1f2f3f4f5f6f7f8f9fafbfcfdfeff'
		actual = string_to_bytes input
		expected = (0..255).to_a
		assert_equal expected, actual
	end
end
