require 'fileutils'
require 'json'
require 'uri'
require 'open-uri'
require 'erb'

module RosettaRock
  class Problem
    attr_accessor :name, :repo, :project_location, \
      :short_description, :long_description, :source, :input, :output

    @long_desc_contents = ''

    def initialize(name, options)
      @name = name.to_s
      @repo = options.repo
      @project_location = File.join(@repo, "problems/#{ @name }")
      @short_description = options.short_description
      @long_description = options.long_description
      @source = options.source_link
      @input = options.input_file
      @output = options.output_file
    end

    def to_s
      "RosettaRock::Problem: {name: #{@name}, repo: #{@repo}, project_location: #{@project_location}, short_description: #{@short_description}, long_description: #{@long_description}, source: #{@source}, input: #{@input}, output: #{@output}}"
    end

    def build_readme_file
      readme_file = File.join(@project_location, 'README.md')
      
      readme_erb_file = File.read('../lib/rosetta_rock/README.md.erb')

      File.open(readme_file, 'w') do |f|
        f.write(ERB.new(readme_erb_file).result(binding))
      end

      File.chmod(0755, readme_file)
      puts "Initialized README in #{ readme_file }"
    end

    def save_config_file
      options = { @name => { } }
      options[@name]['short_description'] = @short_description unless @short_description.empty?
      options[@name]['long_description'] = @long_description unless @long_description.empty?
      options[@name]['source'] = @source unless @source.empty?
      options[@name]['input'] = @input unless @input.empty?
      options[@name]['output'] = @output unless @output.empty?

      File.open(File.join(@project_location, 'config.json'), 'w') do |f|
        f.write(JSON.pretty_generate(options))
      end
    end

    def prompt_for_details
      # initialize the project
      unless Dir.exist?(@project_location)
        FileUtils.mkdir_p(@project_location)
        puts "Successfully Initialized #{ @name } at #{ @project_location }"
      end

      # read existing config
      config_file = File.join(@project_location, 'config.json')

      if File.exist?(config_file)
        config = JSON.parse(File.read(config_file))
      else
        config = { @name => {} }
      end

      # check if specified in commander.  If not, check config file.  Otherwise, prompt.
      if @short_description == "#{ @name } - problem-set"
        @short_description = config[@name]['short_description'] || ask('Short description of problem:')
      end

      unless @long_description
        @long_description = config[@name]['long_description'] || ask('File or URL for full problem description:')
      end

      unless @source
        @source = config[@name]['source'] || ask('Problem URL or Source:')
      end

      unless @input
        @input = config[@name]['input'] || ask('File or URL for input file(s), separated by commas')
      end

      unless @output
        @output = config[@name]['output'] || ask('File or URL for output file(s), separated by commas')
      end

      save_config_file
    end

    def download_files
      if @long_description
        long_desc_uri = URI.parse(@long_description)
        if long_desc_uri.kind_of?(URI::HTTP) or long_desc_uri.kind_of?(URI::HTTPS)
          @long_desc_contents = long_desc_uri.read
        elsif long_desc_uri.kind_of?(URI::Generic)
          @long_desc_contents = File.read(long_desc_uri.to_s)  
        end
      end

      if @input
        input_uri = URI.parse(@input)
        if input_uri.kind_of?(URI::HTTP) or input_uri.kind_of?(URI::HTTPS)
          input_contents = input_uri.read
        elsif input_uri.kind_of?(URI::Generic)
          input_contents = File.read(input_uri.to_s)
        end
        File.open(File.join(@project_location, 'input.txt'), 'w') do |f|
          f.write(input_contents)
        end
      end

      if @output
        output_uri = URI.parse(@output)
        if output_uri.kind_of?(URI::HTTP) or output_uri.kind_of?(URI::HTTPS)
          output_contents = output_uri.read
        elsif output_uri.kind_of?(URI::Generic)
          output_contents = File.read(output_uri.to_s)
        end
        File.open(File.join(@project_location, 'output.txt'), 'w') do |f|
          f.write(output_contents)
        end
      end

    end

  end # Problem class
end # ResettaRock module