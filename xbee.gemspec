# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xbee/version'

Gem::Specification.new do |spec|
	spec.name = 'xbee'
	spec.version = XBee::VERSION
	spec.description = 'A Ruby API for sending/receiving API frames with Digi XBee RF Modules.'
	spec.summary = 'A Ruby API for Digi XBee RF Modules.'
	spec.email = 'rubygems-xbee@aarontc.com'
	spec.authors = ['Dirk Grappendorf (http://www.grappendorf.net)', 'Aaron Ten Clay (https://aarontc.com)']
	spec.homepage = 'https://github.com/IdleEngineers/xbee'
	spec.license = 'MIT'
	spec.metadata = {
		'issue_tracker' => 'https://work.techtonium.com/jira/browse/XBEE',
	}

	spec.files = `git ls-files -z`.split("\x0").reject do |f|
		f.match(%r{^(test|spec|features)/})
	end
	spec.bindir = 'exe'
	spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ['lib']

	spec.add_development_dependency 'bundler', '~> 1'
	spec.add_development_dependency 'minitest', '~> 5'
	spec.add_development_dependency 'minitest-ci', '~> 3'
	spec.add_development_dependency 'minitest-reporters', '~> 1'
	spec.add_development_dependency 'rake', '~> 12'
	spec.add_development_dependency 'rr', '~> 1'
	spec.add_development_dependency 'simplecov', '~> 0'
	spec.add_development_dependency 'simplecov-rcov', '~> 0'
	spec.add_development_dependency 'trollop', '~> 2'

	spec.add_dependency 'serialport', '~> 1'
	spec.add_dependency 'semantic_logger', '~> 4'
end
