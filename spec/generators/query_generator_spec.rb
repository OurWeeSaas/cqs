require "spec_helper"
require "fileutils"
require "generator_spec"
require "generators/cqs/query/query_generator"

RSpec.describe Cqs::Generators::QueryGenerator, type: :generator do
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w[MyQuery]

  before(:each) do
    prepare_destination
    run_generator
  end

  it "creates the file" do
    assert_file "app/queries/query/my_query.rb"
  end

  it "has the right content for a Command" do
    expect(destination_root).to have_structure {
      no_file "my_query.rb"
      directory "app" do
        directory "queries" do
          directory "query" do
            file "my_query.rb" do
              contains File.read("./spec/fixtures/files/generators/my_query.rb")
            end
          end
        end
      end
    }
  end
end
