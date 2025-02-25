# CQS - Command Query Separation for Ruby (and Rails)

[![Gem Version](https://badge.fury.io/rb/cqs.svg)](https://badge.fury.io/rb/cqs)

⚠️ This gem (and readme) are still **Work In Progress** ⚠️

Unlike [CQRS](https://martinfowler.com/bliki/CQRS.html), this gem tries to give a framework that allows to separate _Commands_ from _Queries_ in your [Ruby](https://www.ruby-lang.org) programs.

Working on a [Ruby on Rails](http://rubyonrails.org/) application we got tired and frustrated about the `ApplicationService` pattern that is so prevalent in so many [Rails](http://rubyonrails.org/)
codebases.

Here are a few reasons we did and did not like the pattern:

- A Service can be almost anything
- We are never sure what the service _really_ does and we end up, if not careful, creating similar services
- The language got a little muddled

For these reasons we opted for creating a simpler language in our application.

> When requesting information use a **Query**
>
> When requesting a change use a **Command**

One thing we did not want to implement (_the reason this is not a [CQRS](https://martinfowler.com/bliki/CQRS.html) implementation_) is the strictness of a pure CQRS implementation (_meaning commands can,
and many times will, have return values, specially if you consider a #save action in a Rails app_).


## Usage

Most of the times we use this gem in a [Ruby on Rails](https://rubyonrails.org) project, so the usage examples will be for Rails. If you use it in plain Ruby projects it will still work, you just won't have
access to the generators.

We are opinionated with the use of [RSpec](https://rspec.info) to test drive our code. Let us know if you'd like to have other testing tools supported!

### General assumptions

Commands and Queries operate on a `subject`. The subject is passed into the action by the provided methods (`wtih` for commands, and `in` for queries):

```ruby
FindUser.in(email_address: "test@test.com")
```

You can register methods to change the way you call your action:

```ruby
class FindUser
  include Query
  register_method :by
  ...
```

And then call the action with the method registered:

```ruby
FindUser.by(email_address: "test@test.com")
```

This works for both, `Commands` and `Queries`.

The subject is what's passed into the calling method and can be anything you like (_see below to see how it's used_).

### Queries

Imagine you want to create a query to find a user by passing a hash with some of their attributes (`find_by` in Rails).

To save time and setup you'll run the provided generator:

```bash
rails generate cqs:query FindUser
```

This will create the following files:

```
- app/queries/query/find_user.rb
- spec/queries/query/find_user_spec.rb
```

The generated `Query` looks like so:

```ruby
module Query
  class FindUser
    include Query

    def answer
      raise AnswerUnknownApology.new "Please implement #answer"
    end
  end
end
```

And the corresponding spec:

```ruby
require "rails_helper"

describe Query::FindUser do
  it "does something" do
    pending "test your query"
  end
end
```

First we'd write our spec to ensure our `Query` does what we'd like it to do:

```ruby
require "rails_helper"

describe Query::FindUser do
  it "finds a user by their email address" do
    email_address = { email_address: "test@test.com"}
    expect(User).to receive(:find_by).with(email_address)

    Query::FindUser.by(email_address)
  end
end
```

and the code to make this pass:

```ruby
module Query
  class FindUser
    include Query
    register_method :by

    def answer
      User.find_by(subject)
    end
  end
end
```

Sometimes, to make your code more readable when implementing either a `Command` or a `Query`, you may
want to alias the `subject`. When we do this we can use our aliased name instead of the `subject` itself
like so:

```ruby
module Query
  class FindUser
    include Query
    register_method :by
    subject_alias :email_address

    def answer
      User.find_by(email_address)
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle execute rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OurWeeSaas/cqs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/OurWeeSaas/cqs?tab=coc-ov-file).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CQS project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/OurWeeSaas/cqs?tab=coc-ov-file).
