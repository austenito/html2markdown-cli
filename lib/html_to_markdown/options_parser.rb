require_relative 'html_to_markdown'

class OptionsParser
  attr_accessor :options, :html2md

  def initialize(options)
    @options = options

    if option?(:output_dir)
      @html2md = HtmlToMarkdown.new(options[:output_dir])
    else
      @html2md = HtmlToMarkdown.new
    end
  end

  def parse
    if option?(:file)
      parse_file
    elsif option?(:dir)
      parse_dir
    else
      puts "No options specified. See --help for options"
    end
  end

  private

  def option?(name)
    options["#{name}_given".to_sym]
  end

  def parse_file
    file = options[:file]
    if File.exists?(file)
      convert(file)
    else
      puts "File doesn't exist. Use --help for options"
    end
  end

  def parse_dir
    dir = options[:dir]
    if Dir.exists?(dir)
      files = File.join(dir, "*.html")
      Dir.glob(files).each do |file|
        convert(file)
      end
    else 
      puts "Directory doesn't exist. Use --help for options"
    end
  end

  def convert(file)
    begin
      puts "Converting: #{file}"
      html2md.convert_file(file)
    rescue RuntimeError => e
      puts "Failed to convert: #{file}: #{e}"
    end
  end
end

