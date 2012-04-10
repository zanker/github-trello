$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))
require "github-trello/version"

Gem::Specification.new do |s|
  s.name        = "github-trello"
  s.version     = GithubTrello::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Zachary Anker"]
  s.email       = ["zach.anker@gmail.com"]
  s.homepage    = "http://github.com/zanker/github-trello"
  s.summary     = "Github -> Trello integration"
  s.description = "Enables managing Trello cards through Github posthooks and Git commits"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = "github-trello"

  s.add_runtime_dependency "vegas", "~>0.1.8"
  s.add_runtime_dependency "sinatra", "~>1.3.2"

  s.files        = Dir.glob("lib/**/*") + %w[MIT-LICENSE README.md Rakefile]
  s.executables  = ["trello-web"]
end