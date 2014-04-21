require 'limit_detectors/version'

module LimitDetectors

  # Check whether the condition given in the block
  # occurs at most limit times in the collection
  def at_most(limit, &block)
    ocurrences_of(&block) <= limit
  end

  # Check whether the condition given in the block
  # occurs at least limit times in the collection
  def at_least(limit, &block)
    ocurrences_of(&block) >= limit
  end

  # Count how often the condition given in the block
  # is met for the collection
  def ocurrences_of &block
    inject(0) { |res, el|
      res += 1 if yield el
      res
    }
  end

end
