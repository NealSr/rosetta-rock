
module RosettaRock
  class Problem
    attr_accessor :name, :description, :source, :input, :output

    def initialize(name)
      @name = name.to_s
      @description, @source, @input, @output = '', '', '', ''
    end

    def prompt_for_details
      puts 'sample prompt'
    end

    def create_new_problem
      puts "will create new problem: #{ @name }"
    end

    def update_existing_problem
      puts "will update existing problem: #{ @name }"
    end
  end # Problem class
end # ResettaRock module