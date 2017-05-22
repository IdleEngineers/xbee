# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xbee/version'

Gem::Specification.new do |spec|
	spec.name = 'xbee'
	spec.version = XBee::VERSION
	spec.description = 'A Ruby API for Digi XBee RF Modules'
	spec.summary = 'A Ruby API for Digi XBee RF Modules'
	spec.authors = ['Dirk Grappendorf (http://www.grappendorf.net)', 'Aaron Ten Clay (https://aarontc.com)']
	spec.homepage = 'https://github.com/aarontc/xbee'
	spec.license = 'MIT'

	spec.files = `git ls-files -z`.split("\x0").reject do |f|
		f.match(%r{^(test|spec|features)/})
	end
	spec.bindir = 'exe'
	spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ['lib']

	spec.add_development_dependency 'bundler'
	spec.add_development_dependency 'minitest'
	spec.add_development_dependency 'minitest-ci'
	spec.add_development_dependency 'minitest-reporters'
	spec.add_development_dependency 'rake'
	spec.add_development_dependency 'rr'
	spec.add_development_dependency 'simplecov'
	spec.add_development_dependency 'simplecov-rcov'
	spec.add_development_dependency 'trollop'

	spec.add_dependency 'serialport', '>= 1.1.0'
	spec.add_dependency 'semantic_logger'
end
