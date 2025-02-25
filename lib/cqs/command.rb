require "cqs/base"

module Command
  def self.included(base)
    base.extend Cqs::Base
    base.extend(ClassMethods)
    base.register_method :with
  end

  module ClassMethods
    def execute
      new(nil).execute
    end

    def register_method(method_name)
      _register_method(method_name, :execute)
    end
  end

  def execute
    raise CommandNotFound.new "I'm really sorry, but that command doesn't exist."
  end
end
