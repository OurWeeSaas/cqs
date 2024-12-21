# frozen_string_literal: true

require_relative "cqs/version"

autoload :Command, "cqs/command"
autoload :Query, "cqs/query"

class CommandNotFound < StandardError; end

class AnswerUnknownApology < StandardError; end
