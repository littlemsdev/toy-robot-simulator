$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'toy-robot-simulator/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'toy-robot-simulator'
  s.version     = ToyRobotSimulator::VERSION
  s.authors     = ['Charlene Lopez Taw']
  s.email       = ['tawcharlene@gmail.com']
  s.homepage    = 'https://www.linkedin.com/in/charlenetaw/'
  s.summary     = 'Toy Robot Simulator Test'
  s.description = 'Toy Robot Simulator Test'
  s.license     = 'MIT'

  s.files = Dir['{lib}/**/*.rb', 'LICENSE', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_development_dependency 'rspec'
end
