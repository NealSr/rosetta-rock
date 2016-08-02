# rosetta-rock
Project for building a rosetta-code repository based on http://rosettacode.org programming chrestomathy.

The goal of this project is to have a command-line utility that can be used to create and manage programming problem-set and solutions in various languages.  The idea is to have a quick way to add a 'problem' to a github repo or source folder, then point to a description, input, and output files, and then build various 'solutions' for each problem using 'languages'.  To make the repo browsable and relatable, the idea is to have the problem_repo and solutions located in the same location, and automatically generate a language_repo using github's README syntax to link all of the solutions for each language.


```
  problem_repo
  > problem
    - name # the short problem name - will be the directory name also
    - short_description # a short description of the problem for the readme
    - long_description # a long description (usually a separate file) with the full problem details
    - source_link # a url or other link to attribute the original problem source
    - input # file(s) to pass into the executable - e.g. text input, pictures, etc.
    - output # expected result(s) from solving the problem (optional)
    - solution(s)
       + source # the source code to solve the problem
       + language # the programming language to use (links to language_repo)
       + executable # the location of a compiled executable if the compiler support isn't available yet - e.g. esoteric languages or complex languages
       + command # the command-line string to execute and solve the problem - e.g. java -jar RobotMow.jar lawns.txt
       + notes # any additional notes about the problem set that should be stored in a separate file and displayed on the readme.
  language_repo
  > language # a root location for a supported language
      x version # what version / edition to use, if it matters (it usually will)
      x compiler # what compiler to use to allow automatic processing
      x command_builder # if possible, a utility to build executables and commands for solutions
      - notes # additional notes about a language outside solutions
      - example(s) # additional language examples outside problem_sets and solutions
    *** (link to solutions) ***
```