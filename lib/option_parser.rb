require 'bundler'
require 'trollop'
Bundler.setup
require_relative 'html_to_markdown'

opts = Trollop::options do
  opt :dir, "Directory containing html files to convert", :type => :string
  opt :file, "The file to convert", :type => :string
  opt :output_dir, "The output location of the converted files", :type => :string, :default => "./output"
end

puts opts
#converter = HtmlToMarkdown.new(opts)
#converter.convert
