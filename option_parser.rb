module HtmlToMarkdown
  class OptionsParser
    attr_accessor :options, :html_to_markdown

    def initialize(options)
      @options = options

      if option?(:output_dir)
        @html_to_markdown = HtmlToMarkdown.new(options[:output_dir])
      else
        @html_to_markdown = HtmlToMarkdown.new
      end
      puts @html_to_markdown
    end

    def parse
      if option?(:file)
        parse_file
      elsif option?(:dir)
        parse_dir
      else
        puts "Invalid options. Use --help for options."
      end
    end

    private

    def option?(option)
      options["#{option}_given".to_sym]
    end

    def parse_file
      file = options[:file]
      if File.exists?(file)
        html_to_markdown.convert_file(file)
      else
        "File doesn't exist."
      end
    end

    def parse_dir
      dir = options[:dir]
      if Dir.exists?(dir)
        html_to_markdown.convert_dir(dir)
      else
        "Directory doesn't exist."
      end
    end
  end
end
