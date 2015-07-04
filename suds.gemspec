lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'suds/version'

Gem::Specification.new do |spec|
  spec.name          = "suds"
  spec.version       = SUDS::VERSION
  spec.authors       = ["Devin Riley"]
  spec.email         = ["devinriley84+suds@gmail.com"]
  spec.summary       = %q{A single user dungeon game framework}
  spec.description   = %q{A single user dungeon game framework}
  spec.homepage      = "https://github.com/DevinRiley/suds"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
