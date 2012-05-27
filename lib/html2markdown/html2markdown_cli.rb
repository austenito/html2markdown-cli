require 'reverse-markdown'
require 'fileutils'

class Html2MarkdownCli
  attr_accessor :output_dir

  def initialize(output_dir = "#{Dir.pwd}/output")
    @output_dir = output_dir
    create_dir(output_dir)
  end

  def convert_file(file_name)
    reverse_md = ReverseMarkdown.new
    contents = File.open(file_name).read
    markdown = reverse_md.parse_string(contents)
    write_file(file_name, markdown, output_dir)
  end

private
  def create_dir(dir)
    unless Dir.exists?(dir)
      FileUtils.mkdir(dir)
    end
  end    

  def valid_file?(file)
    file.include?(".html") || file.include?(".htm")
  end

  def write_file(file_name, markdown_string, output_dir)
    file_name = file_name.gsub(".html", ".markdown")
    file = File.new("#{output_dir}/#{File.basename(file_name)}", "w")
    file.write(markdown_string)
    file.close
  end
end
