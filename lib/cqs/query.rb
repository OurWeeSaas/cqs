require "cqs/base"

module Query
  def self.included(base)
    base.extend Cqs::Base
    base.extend(ClassMethods)
    base.register_method :in
  end

  module ClassMethods
    def register_method(method_name)
      _register_method(method_name, :answer)
    end

    def answer
      new(nil).answer
    end
  end

  def answer
    raise AnswerUnknownApology.new "I'm really sorry, but I don't have any answer for you."
  end
end
