module Cqs
  class Error < StandardError; end

  module Base
    def self.extended(base)
      base.extend ClassMethods
      base.prepend InstanceMethods
    end

    module InstanceMethods
      def initialize(subject)
        @subject = subject
      end

      def subject
        @subject
      end
    end

    module ClassMethods
      def _register_method(method_name, executor)
        define_singleton_method(method_name) do |subject|
          new(subject).send(executor)
        end
      end

      def subject_alias(alias_subject)
        class_eval %(
          def #{alias_subject}
            @subject
          end
        ), __FILE__, __LINE__ - 4
      end
    end
  end
end
