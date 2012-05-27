Gem::Specification.new do |s|
  s.name        = 'html2markdown-cli'
  s.version     = '0.0.2'
  s.date        = '2011-05-27'
  s.summary     = "Command-line utility to convert HTML files into Markdown"
  s.description = "Command-line utility to convert HTML files into Markdown"
  s.authors     = ["Austen Ito"]
  s.email       = 'austen.dev@gmail.com'
  s.files       = Dir.glob("lib/**/*") 
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "reverse-markdown"
  s.add_runtime_dependency "trollop"
  s.homepage    = 'https://github.com/austenito/html2markdown-cli'
  s.executables << 'html2markdown-cli'
end
