# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carthage_cache_res/version'
require 'carthage_cache_res/description'

Gem::Specification.new do |spec|
  spec.name          = "carthage_cache_res"
  spec.version       = CarthageCacheRes::VERSION
  spec.authors       = ["Guido Marucci Blas", "dokim"]
  spec.email         = ["guidomb@gmail.com", "doublekick132@gmail.com"]

  spec.summary       = CarthageCacheRes::DESCRIPTION
  spec.description   = %q{
    CarthageCache generate a hash key based on the content of your Cartfile.resolved and checks
    if there is a cache archive (a zip file of your Carthage/Build directory) associated to that hash.
    If there is one it will download it and install it in your project avoiding the need to run carthage bootstrap.
    -------Thanks Mr.Blas but now we are facing dependency conflict with Fastlane 2.144--------
    What I want to solve: Dependency conflict with Fastlane 2.144
    What I did: 
      1. Changed name of this gem to "carthage_cache_res"
      2. Fixed runtime dependencies: aws-sdk > 3.0, commander = 4.3.8
      3. Changed system dependency versions: ruby > 2.6, xcode 11.x
  }
  spec.homepage      = "https://github.com/dokim/carthage_cache_res"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.2.3"

  spec.add_dependency "aws-sdk", "~> 3.0"
  spec.add_dependency "commander", "=4.3.8"
end
