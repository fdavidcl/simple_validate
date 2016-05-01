# SimpleValidate

Borrowing ideas from [validatable](https://github.com/jnunemaker/validatable) and Rails validations, this is a library for validations for any ruby object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_validate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_validate

## Usage

```ruby
require 'simple_validate'

class Person
  include SimpleValidate
  attr_accessor :name, :age
  
  validates_presence_of :name, :age
  validates_numericality_of :age
end

=> p = Person.new
=> #<Person:0x007f9431536408>
=> p.valid?
=> false
=> p.errors
=> #<SimpleValidate::Errors:0x007f94318b4df0
 @messages=
  {:age=>["can't be empty", "must be a number"],
   :name=>["can't be empty"]}>
```

## Development

`$ rake` to run the specs

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nikkypx/simple_validate.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

