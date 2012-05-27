require 'bundler'
Bundler.setup
require 'reverse-markdown'

class HtmlToMarkdown
  attr_accessor :output_dir

  def initialize(output_dir = "#{Dir.pwd}/output")
    @output_dir = output_dir
    create_dir(output_dir)
  end

  def convert_file(file_name)
    puts "Converting: #{file_name}"
    reverse_md = ReverseMarkdown.new
    contents = File.open(file_name).read
    markdown = reverse_md.parse_string(contents)
    write_file(file_name, markdown, output_dir)
  end


  def convert_dir(dir_name)
    files = File.join(dir_name, "*.html")
    Dir.glob(files).each do |file|
      convert_file(file)
    end
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

  #def validate
  #bc = BlueCloth.new(your_markdown_string_attribute)
  #begin
  #bc.to_html
  #rescue
  #errors.add(:your_markdown_string_attribute, 'has invalid markdown syntax')
  #end
  #end
