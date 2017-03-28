Gem::Specification.new do |s|
  s.name          = "apalyze"
  s.description   = %q{A Ruby library for sending events to Apalyze}
  s.summary       = s.description
  s.homepage      = "https://github.com/adamcooke/apalyze"
  s.version       = '1.0.0'
  s.files         = Dir.glob("{lib}/**/*")
  s.require_paths = ["lib"]
  s.authors       = ["Adam Cooke"]
  s.email         = ["me@adamcooke.io"]
  s.licenses      = ['MIT']
  s.add_runtime_dependency("json")
end
