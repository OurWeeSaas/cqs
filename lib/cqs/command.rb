require "cqs/base"

module Command
  include Cqs::Base

  def self.included(base)
    base.extend(ClassMethods)
    base.register_method :with
  end

  module ClassMethods
    def register_method(method_name)
      define_singleton_method(method_name) do |subject|
        new(subject).execute
      end
    end

    def execute
      new(nil).execute
    end
  end

  def execute
    raise CommandNotFound.new "I'm really sorry, but that command doesn't exist."
  end
end
