require 'limit_detectors/version'

module LimitDetectors
  def at_most(limit)
    count = inject(0){ |res, el|
      res += 1 if yield el
      res
    }
    count <= limit
  end

  def at_least(limit)
    count = inject(0){ |res, el|
      res += 1 if yield el
      res
    }
    count >= limit
  end
end
