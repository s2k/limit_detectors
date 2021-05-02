puts RUBY_DESCRIPTION
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
