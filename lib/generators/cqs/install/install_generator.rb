module Cqs::Generators
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    def create_intializer
      template "cqs.rb.erb", Rails.root.join("config/initializers/cqs.rb")
    end
  end
end
