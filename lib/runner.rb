require 'trollop'
require_relative 'html2markdown/options_parser'

p = Trollop::Parser.new do
  opt :dir, "Directory containing html files to convert", :type => :string
  opt :file, "The file to convert", :type => :string
  opt :output_dir, "The output location of the converted files", :type => :string
end

opts = Trollop::with_standard_exception_handling p do
  raise Trollop::HelpNeeded if ARGV.empty?
  p.parse ARGV
end

OptionsParser.new(opts).parse

