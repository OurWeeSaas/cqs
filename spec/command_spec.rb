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
end

RSpec.describe Command do
  it "raises error when execute is not implemented" do
    expect { Command::MyBrokenCommand.with("this string") }.to raise_error CommandNotFound
  end

  it "executes" do
    expect(Command::Add.with([1, 2, 3, 5])).to be 11
  end

  it "can register different method names to execute" do
    Command::Add.register_method :numbers
    expect(Command::Add.numbers([1, 2, 3, 5])).to be 11
  end
end
