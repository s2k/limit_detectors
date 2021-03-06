# frozen_string_literal: true

require 'limit_detectors/version'

module LimitDetectors
  # Deprecated, use at_most? instead
  def at_most(limit, &block)
    Kernel.warn "'at_most' is deprecated, use 'at_most?' instead"
    at_most? limit, &block
  end

  # Deprecated, use at_least? instead
  def at_least(limit, &block)
    Kernel.warn "'at_least' is deprecated, use 'at_least?' instead"
    at_least? limit, &block
  end

  # Check whether the condition given in the block
  # occurs at most limit times in the collection
  def at_most?(limit, &block)
    occurrences_of(&block) <= limit
  end

  # Check whether the condition given in the block
  # occurs at least limit times in the collection
  def at_least?(limit, &block)
    occurrences_of(&block) >= limit
  end

  # Count how often the condition given in the block
  # is met for the collection
  def occurrences_of
    inject(0) do |res, el|
      res += 1 if yield el
      res
    end
  end
end
