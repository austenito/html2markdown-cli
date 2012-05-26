require 'reverse-markdown'

class HtmlToMarkdown
  attr_reader :opts

  def initialize(opts)
    @opts = opts
  end

  def convert
    FileUtils.mkdir(opts[:output_dir])

    if opts[:file_given]
      file_name = opts[:file]
      if valid_file?(file_name)
        markdown = convert_file(file_name)
        write_file(file_name, markdown, opts[:output_dir])
      end
    elsif opts[:dir_given]
    end
  end

private
  def convert_file(file_name)
    reverse_md = ReverseMarkdown.new
    contents = File.open(file_name).read
    reverse_md.parse_string(contents)
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
