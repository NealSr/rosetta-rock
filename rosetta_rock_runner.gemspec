# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'rosetta_rock/version'

Gem::Specification.new do |s|
  s.name        = 'rosetta_rock'
  s.version     = RosettaRock::VERSION
  s.authors     = ['Neal Richardson Sr']
  s.email       = ['Neal.Sr@outlook.com']
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/NealSr/rosetta-rock'
  s.summary     = 'Project for building a rosetta-code repository based on http://rosettacode.org programming chrestomathy.'
  s.description = "The goal of this project is to have a command-line utility that can be used to create and manage programming problem-set and solutions in various languages. The idea is to have a quick way to add a 'problem' to a github repo or source folder, then point to a description, input, and output files, and then build various 'solutions' for each problem using 'languages'. To make the repo browsable and relatable, the idea is to have the problem_repo and solutions located in the same location, and automatically generate a language_repo using github's README syntax to link all of the solutions for each language."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end