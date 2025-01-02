require "spec_helper"

module Query
  class MyQuery
    include Query
  end

  class HowManyCharactersAre
    include Query

    def answer
      subject.size
    end
  end

  class AmICool
    include Query

    def answer
      "YES!"
    end
  end
end

RSpec.describe Query do
  it "not have any answers when the answer wasn't implemented" do
    expect { Query::MyQuery.in("this string") }.to raise_error AnswerUnknownApology
    expect { Query::MyQuery.answer }.to raise_error AnswerUnknownApology
  end

  it "have an answer when implemented" do
    answer = Query::HowManyCharactersAre.in("This string")

    expect(answer).to be 11
  end

  it "can answer without a subject, but it must be implemented" do
    expect(Query::AmICool.answer).to eql "YES!"
  end
end
