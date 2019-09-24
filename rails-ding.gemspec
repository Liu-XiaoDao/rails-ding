$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails/ding/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails-ding"
  s.version     = Rails::Ding::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "http://www.liuxiaodao.top"
  s.summary     = "Ding API"
  s.description = "DingDing API"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.6"

  s.add_development_dependency "sqlite3"
end
