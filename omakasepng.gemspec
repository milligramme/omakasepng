# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omakasepng/version'

Gem::Specification.new do |spec|
  spec.name          = "omakasepng"
  spec.version       = Omakasepng::VERSION
  spec.authors       = ["milligramme"]
  spec.email         = ["milligramme.cc@gmail.com"]
  spec.description   = %q{generate random png with omakase page source of ja.wikipedia.org}
  spec.summary       = %q{generate random png with omakase page source of ja.wikipedia.org}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  
  spec.add_dependency "nokogiri"
end
