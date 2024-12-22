module Cqs::Generators
  class QueryGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def create_query_file
      template "query.rb", File.join(
        "app/queries/query",
        "#{file_name}.rb"
      )
    end

    def create_query_spec_file
      template "query_spec.rb", File.join(
        "spec/queries/query",
        "#{file_name}_spec.rb"
      )
    end
  end
end
