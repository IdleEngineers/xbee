lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xbee-ruby/version'

Gem::Specification.new do |spec|
	spec.name = 'xbee'
	spec.version = XBee::VERSION
	spec.description = 'A Ruby API for Digi XBee RF Modules'
	spec.summary = 'A Ruby API for Digi XBee RF Modules'
	spec.authors = ['Dirk Grappendorf (http://www.grappendorf.net)', 'Aaron Ten Clay <aarontc@aarontc.com>']
	spec.homepage = 'https://github.com/aarontc/xbee'
	spec.license = 'MIT'

	spec.files = Dir.glob('lib/**/*.{rb,yml}') + Dir.glob('vendor/**/*.*')
	spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = %w(lib)

	spec.add_development_dependency 'bundler', '>= 1.3.0'
	spec.add_development_dependency 'rake', '>= 10.0.0'
	spec.add_development_dependency 'rspec', '>= 2.14.0'
	spec.add_development_dependency 'simplecov', '>= 0.8.0'

	spec.add_dependency 'serialport', '>= 1.1.0'
end
