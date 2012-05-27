require 'rspec'
require_relative '../lib/html_to_markdown'
require 'tmpdir'

describe HtmlToMarkdown do
  let(:output_dir) { Dir.mktmpdir }
  let(:input_filename) { "test.html" }
  let(:other_input_filename) { "test2.html" }
  let(:input_dirname) { "#{File.dirname(__FILE__)}/test_data" }
  let(:input_file) { "#{input_dirname}/#{input_filename}"}
  let(:markdown_file) { input_filename.gsub("html", "markdown") }
  let(:other_markdown_file) { other_input_filename.gsub("html", "markdown") }

  after(:all) do 
    FileUtils.remove_entry_secure(output_dir)
  end

  context "#convert_file" do
    context "when no output directory is specified" do
      let(:html_to_md) { HtmlToMarkdown.new }
      after(:each) do
        FileUtils.remove_entry_secure(html_to_md.output_dir)
      end

      it "creates a markdown file in ./output" do
        html_to_md.convert_file(input_file)
        Dir.entries(html_to_md.output_dir).include?(markdown_file).should == true
      end
    end

    context "when an output directory is specified" do
      let(:html_to_md) { HtmlToMarkdown.new(output_dir) }
      after(:each) do
        FileUtils.remove_entry_secure(html_to_md.output_dir)
      end

      it "creates a markdown file in the specified output dir" do
        html_to_md.convert_file(input_file)
        Dir.entries(output_dir).include?(markdown_file).should == true
      end
    end
  end

  context "#convert_dir" do
    context "when no output directory is specified" do
      let(:html_to_md) { HtmlToMarkdown.new }
      after(:each) do
        FileUtils.remove_entry_secure(html_to_md.output_dir)
      end

      it "creates markdown files in ./output" do
        html_to_md.convert_dir(input_dirname)
        Dir.entries(html_to_md.output_dir).include?(markdown_file).should == true
        Dir.entries(html_to_md.output_dir).include?(other_markdown_file).should == true
      end
    end

    context "when output directory is specified" do
      let(:html_to_md) { HtmlToMarkdown.new(output_dir) }
      after(:each) do
        FileUtils.remove_entry_secure(html_to_md.output_dir)
      end

      it "creates markdown files in specified output dir" do
        html_to_md.convert_dir(input_dirname)
        Dir.entries(output_dir).include?(markdown_file).should == true
        Dir.entries(output_dir).include?(other_markdown_file).should == true
      end
    end
  end
end

