# frozen_string_literal: true

require_relative "lib/cqs/version"

Gem::Specification.new do |spec|
  spec.name = "cqs"
  spec.version = Cqs::VERSION
  spec.authors = ["Enrique Comba Riepenhausen"]
  spec.email = ["enrique@ecomba.pro"]

  spec.summary = "Command Query Separation simplified for ruby (and rails)"
  spec.description = "cqs allows you to separate queries from commands for a better segregation of concerns."
  spec.homepage = "https://github.com/OurWeeSaas/cqs"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/OurWeeSaas/cqs"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end

  spec.platform = Gem::Platform::RUBY
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "railties", ">= 6.1", "< 9"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
