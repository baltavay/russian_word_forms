# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'russian_word_forms/version'

Gem::Specification.new do |spec|
  spec.name          = "russian_word_forms"
  spec.version       = RussianWordForms::VERSION
  spec.authors       = ["Maksatbek Mansurov"]
  spec.email         = ["maksat.mansurov@gmail.com"]
  spec.description   = %q{Gem detects wordforms. It uses russian ispell dictionary written by Alexander I. Lebedev}
  spec.summary       = %q{Gem detects wordforms}
  spec.homepage      = "https://github.com/baltavay/russian_word_forms"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
