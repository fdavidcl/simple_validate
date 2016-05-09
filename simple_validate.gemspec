# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_validate/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_validate'
  spec.version       = SimpleValidate::VERSION
  spec.authors       = ['Nick Palaniuk']
  spec.email         = ['npalaniuk@gmail.com']

  spec.summary       = 'Validations for any plain old ruby object'
  spec.description   = 'Validations for any ruby object'
  spec.homepage      = 'https://github.com/nikkypx/simple_validate'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport',       '~> 4.2'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.0'
end
