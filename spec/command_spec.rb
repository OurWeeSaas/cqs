require "spec_helper"

module Command
  class MyBrokenCommand
    include Command
  end

  class Add
    include Command

    def execute
      subject.inject(0, :+)
    end
  end

  class Executor
    include Command

    def execute
      "I ran!"
    end
  end

  class DifferentNameForSubject
    include Command

    def execute
      string
    end
  end
end

RSpec.describe Command do
  it "raises error when execute is not implemented" do
    expect { Command::MyBrokenCommand.with("this string") }.to raise_error CommandNotFound
    expect { Command::MyBrokenCommand.execute }.to raise_error CommandNotFound
  end

  it "executes" do
    expect(Command::Add.with([1, 2, 3, 5])).to be 11
  end

  it "can register different method names to execute" do
    Command::Add.register_method :numbers
    expect(Command::Add.numbers([1, 2, 3, 5])).to be 11
  end

  it "can execute without a subject, but it must be implemented" do
    expect(Command::Executor.execute).to eql "I ran!"
  end

  it "can change the 'subjects' name" do
    Command::DifferentNameForSubject.subject_alias :string
    expect { Command::DifferentNameForSubject.with("A string") }.not_to raise_error
  end
end
