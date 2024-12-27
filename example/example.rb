# frozen_string_literal: true

require 'limit_detectors'

# A simple Example class to demonstrate how the
# methods from limit_detectors can be used.
#
class Example
  include Enumerable
  def each(&)
    ('a'..'d').each(&)
  end
end

e = Example.new
e.extend LimitDetectors

puts e.at_least?(1) { |c| c == 'f' }
puts e.at_least?(1) { |c| c == 'b' }
puts e.at_most?(0)  { |c| c == 'b' }
puts e.at_most?(42) { |c| c == 'b' }
