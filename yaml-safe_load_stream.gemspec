
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yaml/safe_load_stream/version"

Gem::Specification.new do |spec|
  spec.name          = "yaml-safe_load_stream"
  spec.version       = YAMLSafeLoadStream::VERSION
  spec.authors       = ["Kimmo Lehto"]
  spec.email         = ["info@kontena.io"]
  spec.license       = "Apache-2.0"

  spec.summary       = %q{Adds YAML.safe_load_stream for safely parsing multi-document YAML streams}
  spec.description   = %q{The Ruby standard library defines YAML.safe_load and YAML.load_stream but there's no way to safely load a multi document stream. This Gem adds YAML.safe_load_stream.}
  spec.homepage      = "https://github.com/kontena/yaml-safe_load_stream"

  spec.files         = Dir[*%w(lib/yaml/safe_load_stream.rb lib/yaml/safe_load_stream/core-ext.rb LICENSE README.md)]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.4'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rspec", "~> 3.0"
end
