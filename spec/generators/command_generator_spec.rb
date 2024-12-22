require "spec_helper"
require "generator_spec"
require "generators/cqs/command/command_generator"

RSpec.describe Cqs::Generators::CommandGenerator, type: :generator do
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w[MyCommand]

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates the file" do
    assert_file "app/commands/command/my_command.rb"
  end

  it "has the right content for a Command" do
    expect(destination_root).to have_structure {
      no_file "my_command.rb"
      directory "app" do
        directory "commands" do
          directory "command" do
            file "my_command.rb" do
              contains File.read("./spec/fixtures/files/generators/my_command.rb")
            end
          end
        end
      end
    }
  end
end
