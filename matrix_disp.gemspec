# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matrix_disp/version'

Gem::Specification.new do |spec|
  spec.name          = "matrix_disp"
  spec.version       = MatrixDisp::VERSION
  spec.authors       = ["Jonás López Mesa", "Sergio"]
  spec.email         = ["alu0100608359@ull.edu.es", "alu0100706468@ull.edu.es"]
  spec.description   = %q{Gema para realizar operaciones básicas con matrices (Tanto densas como dispersas)}
  spec.summary       = %q{Gema para realizar operaciones básicas con matrices (Tanto densas como dispersas)}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end


