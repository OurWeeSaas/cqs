module Command
  class MyCommand
    include Command

    def execute
      raise CommandNotFound.new "Please implement #execute"
    end
  end
end
