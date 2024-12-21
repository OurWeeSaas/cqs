require "cqs/base"

module Query
  include CQS::Base

  def self.included(base)
    base.extend(ClassMethods)
    base.register_method :in
  end

  module ClassMethods
    def register_method(method_name)
      define_singleton_method(method_name) do |subject|
        new(subject).answer
      end
    end
  end

  def answer
    raise AnswerUnknownApology.new "I'm really sorry, but I don't have any answer for you."
  end
end
