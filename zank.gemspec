# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zank/version'

Gem::Specification.new do |s|
  s.name          = 'zank'
  s.version       = Zank::VERSION
  s.date          = '2016-10-10'
  s.summary       = 'zank data'
  s.description   = 'zank data'
  s.authors       = ['fwshun8023']
  s.email         = ['fwshun8023@gmai.com']
  s.homepage      = 'https://github.com/fwshun8023/zank'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($RS)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'bundler', '~> 1.3'
  s.add_dependency 'rake', '~> 11.3'
  s.add_dependency 'faraday', '~> 0.9.2'
  s.add_dependency 'uuid', '~> 2.3.8'
end
