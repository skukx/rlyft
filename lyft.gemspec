# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lyft/version'

Gem::Specification.new do |spec|
  spec.name          = "rlyft"
  spec.version       = Lyft::VERSION
  spec.authors       = ["Taylor Scott"]
  spec.email         = ["t.skukx@gmail.com"]

  spec.summary       = %q{Ruby wrapper for Lyft API.}
  spec.description   = %q{Ruby wrapper for Lyft API.}
  spec.homepage      = "https://github.com/skukx/lyft"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = "https://github.com/skukx/lyft"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "yard"
end
