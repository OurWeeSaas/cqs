module Query
  class MyQuery
    include Query

    def answer
      raise AnswerUnknownApology.new "Please implement #answer"
    end
  end
end
