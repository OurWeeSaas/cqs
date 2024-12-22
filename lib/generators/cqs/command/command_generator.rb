module Cqs::Generators
  class CommandGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def create_command_file
      template "command.rb", File.join(
        "app/commands/command",
        "#{file_name}.rb"
      )
    end

    def create_command_spec_file
      template "command_spec.rb", File.join(
        "spec/commands/command",
        "#{file_name}_spec.rb"
      )
    end
  end
end
