# LimitDetectors

Some methods to detect whether an Enumberable object contains a constrained number of elements that match a given condition

## Stati

* Travis CI: [![Build Status](https://travis-ci.org/s2k/limit_detectors.svg?branch=master)](https://travis-ci.org/s2k/limit_detectors)
* Maintenance: [![Project Status](http://stillmaintained.com/s2k/limit_detectors.png)](http://stillmaintained.com/s2k/limit_detectors)

## Installation

Add this line to your application's Gemfile:

    gem 'limit_detectors'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install limit_detectors

## Usage

In your code you can `require 'limit_detectors'` then define you classes (or use built-in classes like Array, Hash or other enumerable objects),
exdent these objects with LimitDetectors (or include the module in your class) and then call `at_most`
on your object.

For example:

    $pry -I lib -r limit_detectors
    [1] pry(main)> a = [1, 2, 3, 4, 5]
    => [1, 2, 3, 4, 5]
    [2] pry(main)> a.extend LimitDetectors
    => [1, 2, 3, 4, 5]
    [3] pry(main)> a.at_most(4){|e| e.odd?}
    => true # There are indeed no more than 4 odd numbers in the array
    [4] pry(main)> a.at_most(1){|e| e.even?}
    => false # In fact there are two even numbers in the array

## Contributing

1. Fork it ( https://github.com/[my-github-username]/limit_detectors/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
