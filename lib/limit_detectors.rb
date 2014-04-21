require 'limit_detectors/version'

module LimitDetectors

  def at_most(limit, &block)
    ocurrences_of(&block) <= limit
  end

  def at_least(limit, &block)
    ocurrences_of(&block) >= limit
  end

  def ocurrences_of &block
    inject(0) { |res, el|
      res += 1 if yield el
      res
    }
  end

end
