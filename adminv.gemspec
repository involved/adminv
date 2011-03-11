# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adminv/version"

Gem::Specification.new do |s|
  s.name        = "adminv"
  s.version     = Adminv::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jordan Lewis", "Nicholas Bruning"]
  s.email       = ["jordan@involved.com.au", "nicholas@bruning.com.au"]
  s.homepage    = ""
  s.summary     = %q{Adminv is an administrative layout for Rails, taking all the work out of making your app administration pretty.}
  s.description = %q{Adminv is an administrative layout for Rails, which includes view helpers to make creating usable and pretty administrative consoles a snap.}

  s.rubyforge_project = "adminv"

  s.add_dependency("rails", [">3.0.0"])

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
