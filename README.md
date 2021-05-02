# LimitDetectors

Some methods to detect whether an Enumberable object contains a constrained number of elements that match a given condition

A second reason to create this gem is to explore various other services -- see the status list below.

## Stati

* Version: [![Gem Version](https://badge.fury.io/rb/limit_detectors.svg)](http://badge.fury.io/rb/limit_detectors)
* Travis CI: [![Build Status](https://travis-ci.com/s2k/limit_detectors.svg?branch=main)](https://travis-ci.com/s2k/limit_detectors)
* Code Climate: [![Code Climate](https://codeclimate.com/github/s2k/limit_detectors.png)](https://codeclimate.com/github/s2k/limit_detectors)


## Installation

Add this line to your application's Gemfile:

    gem 'limit_detectors'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install limit_detectors

## Usage

In your code, you can `require 'limit_detectors'` then define your classes and `include` module `LimitDetectors` in your class, or create enumerable objects and `extend` these objects with `LimitDetectors`. Then call `at_most?` (or `t_least?`) on your object.

For example using `pry`(you can use `irb` as well) you can do this:

```ruby
$pry -I lib -r limit_detectors
[1] pry(main)> a = [1, 2, 3, 4, 5]
=> [1, 2, 3, 4, 5]
[2] pry(main)> a.extend LimitDetectors
=> [1, 2, 3, 4, 5]
[3] pry(main)> a.at_most?(4){|e| e.odd?}
=> true # There are indeed no more than 4 odd numbers in the array
[4] pry(main)> a.at_most?(1){|e| e.even?}
=> false # In fact there are two even numbers in the array
```

In code the usage may look like this (see example/example.rb for the file):

```ruby
require 'limit_detectors'

class Example
  include Enumerable
  def each
    ('a'..'d').each { |c| yield c }
  end
end

e = Example.new
e.extend LimitDetectors


puts e.at_least?(1) { |c| 'f' == c }
puts e.at_least?(1) { |c| 'b' == c }
puts e.at_most?(0) { |c| 'b' == c }
puts e.at_most?(42) { |c| 'b' == c }
```



## Compatibility

This gem is tested with these Ruby versions (MRI, unless JRuby):

  - 2.6.7
  - 2.7.3
  - 3.0.1

as well as a current version of JRuby.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/limit_detectors/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

A more detailed descritpion is at https://opensource.com/article/19/7/create-pull-request-github

### Reporting a bug

Please, provide answers to the following questions, when submitting a bug report:

1. What's _actually_ happening? What is the observed behaviour?
2. What's the _expectation_, i.e. what should have happened?
3. Why did you expect this behaviour?

If you provide an `RSpec` check that demonstrates the bug, would give extra good karma,
especially in case of a minimal check, something that just demonstrates the bug without
any (or much) overhead.
