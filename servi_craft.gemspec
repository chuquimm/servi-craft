# frozen_string_literal: true

require_relative 'lib/servi_craft/version'

Gem::Specification.new do |spec|
  spec.name = 'servi-craft'
  spec.version = ServiCraft::VERSION
  spec.authors = ['Marcos Chuquicondor']
  spec.email = ['marcos@chuquicondor.com']
  spec.licenses = ['MIT']

  spec.summary = 'Manage Service Objects.'
  spec.description = 'Manage Ruby Service Objects.'
  spec.homepage = 'https://github.com/chuquimm/servi-craft.'
  spec.required_ruby_version = '>= 2.6.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  spec.files = [
    'lib/servi_craft.rb',
    'lib/servi_craft/create.rb',
    'lib/servi_craft/destroy.rb',
    'lib/servi_craft/query.rb',
    'lib/servi_craft/update.rb',
    'lib/servi_craft/version.rb',
    'lib/generators/servi_craft/servi_craft_generator.rb',
    'lib/generators/servi_craft/templates/create.template',
    'lib/generators/servi_craft/templates/destroy.template',
    'lib/generators/servi_craft/templates/info.template',
    'lib/generators/servi_craft/templates/query.template',
    'lib/generators/servi_craft/templates/update.template'
  ]
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(__dir__) do
  #   `git ls-files -z`.split("\x0").reject do |f|
  #     (File.expand_path(f) == __FILE__) ||
  #       f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
  #   end
  # end
  # spec.bindir = "exe"
  # spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  # spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'echo-craft', '~> 0.1.3'
  spec.add_dependency 'model-ancestry', '~> 0.1.0'
  spec.add_dependency 'rails', '>= 7.0.0', '< 9.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
