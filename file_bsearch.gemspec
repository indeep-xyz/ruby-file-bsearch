# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'file_bsearch/version'

Gem::Specification.new do |spec|
  spec.name          = "file_bsearch"
  spec.version       = FileBsearch::VERSION
  spec.authors       = ["indeep-xyz"]
  spec.email         = ["indeep.xyz@gmail.com"]
  spec.summary       = %q{binary search for sorted text file.}
  spec.description   = <<EOS
binary search for sorted text file. it is effective when file size is bigger.
EOS
  spec.homepage      = "https://github.com/indeep-xyz/ruby-file-bsearch/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 1.9'

  spec.add_runtime_dependency "file_char_licker", "~> 0.5"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
end
