module Cqs
  class Error < StandardError; end

  module Base
    def self.included(base)
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
  end
end
