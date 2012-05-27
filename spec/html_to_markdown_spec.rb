require 'rspec'
require_relative '../lib/html_to_markdown'
require 'tmpdir'

describe HtmlToMarkdown do
  let(:output_dir) { Dir.mktmpdir }
  let(:input_filename) { "test.html" }
  let(:input_file) { "#{File.dirname(__FILE__)}/test_data/#{input_filename}"}
  let(:markdown_file) { input_filename.gsub("html", "markdown") }

  after(:all) do 
    FileUtils.remove_entry_secure(output_dir)
  end

  context "when no output directory is specified" do
    let(:html_to_md) { HtmlToMarkdown.new }
    
    after(:each) do
      FileUtils.remove_entry_secure(html_to_md.output_dir)
    end

    context "#convert_file" do
      it "creates a markdown file in ./output" do
        html_to_md.convert_file(input_file)
        Dir.entries(html_to_md.output_dir).include?(markdown_file).should == true
      end
    end
  end
end

