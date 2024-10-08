# frozen_string_literal: true

require 'set'

Array.include LimitDetectors

describe '#at_most' do
  it 'is true for an empty Array' do
    expect(Kernel).not_to receive(:warn)
    expect([]).to be_at_most(5) { true }
    expect([]).to be_at_most(0) { true }
    expect([]).to be_at_most(1) { true }
    expect([]).to be_at_most(5) { :foo }
  end

  it 'is true if the criterion is met once' do
    expect(["it's there"]).to be_at_most(1) { |el| el == "it's there" }
  end

  it 'is true if all elements meet the criterion and the size is the given maximum number' do
    expect([1, 1, 1]).to be_at_most(3) { |e| e == 1 }
  end

  it 'is false if not enough elements meet the criterion' do
    expect([1, 2, 4]).not_to be_at_most(1, &:even?)
  end

  it 'is true if 0 elements are expected to match' do
    r = Array.new(10) { rand }
    expect(r).to be_at_most(0) { |i| i > 2 }
  end

  describe 'Hash#at_most' do
    Hash.include LimitDetectors
    it 'detects a condition based on key as well as value properties' do
      h = { 'foo' => 1, 'bar' => 4, 'baz' => 5, 'bum' => 1, 'fum' => 0 }
      expect(h).to be_at_most(3) { |ky, vl| ky.match(/^b/) || vl > 1 }
    end
  end
end

describe Array, '#at_least' do
  it 'is false for an empty Array, if at least one is expected' do
    expect(Kernel).not_to receive(:warn)
    [].at_least?(2) { |i| i > 2 }
  end

  it 'is false for empty Arrays when one elements is expected' do
    expect([]).not_to be_at_least(1) { false }
  end

  it 'is true if the expected number is 0 and Hash is empty' do
    expect({}).to be_at_least(0) { false }
  end

  it 'is true if the expected number is 0 and Array is empty' do
    expect([]).to be_at_least(0) { true }
  end

  it 'is false if the container ist smaller than the expected number' do
    size = 10
    expect(described_class.new(size)).not_to be_at_least(size + 1) { true }
  end

  it 'is true if the criterion is met and expected once' do
    expect(["it's there"]).to be_at_least(1) { |el| el == "it's there" }
  end

  it 'is false for an empty Array if you expect at least 1' do
    expect([]).not_to be_at_least(1) { true }
  end

  it 'is true for an empty Array if you expect at least 0' do
    expect([]).to be_at_least(0) {}
  end

  it 'is true if the criterion is met once' do
    expect(["it's there", "it's there"]).to be_at_least(1) { |el| el == "it's there" }
  end

  it 'is true if all elements meet the criterion and the size is the given minimum number' do
    expect([1, 1, 1]).to be_at_least(3) { |e| e == 1 }
  end

  it 'is true if enough elements meet the criterion' do
    expect([1, 2, 4, 8].at_least(2, &:even?)).to be_truthy
  end

  it 'is true if there are enough matching elements' do
    r = described_class.new(10) { |i| i }
    expect(r).to be_at_least(7) { |i| i > 2 }
  end

  it 'is false if there are too few matching elements' do
    r = described_class.new(10) { |i| i }
    expect(r).not_to be_at_least(8) { |i| i > 2 }
  end
end

describe LimitDetectors, '#ocurrences_of' do
  context 'when the collection has some content' do
    Set.include described_class
    subject { Set.new([1, 2, 3, 4, 5, 6, 7]) }

    it('counts 3 even numbers')     { expect(subject.occurrences_of(&:even?)).to be 3 }
    it('counts 4 odd numbers')      { expect(subject.occurrences_of(&:odd?)).to be 4 }
    it('counts no number < 0')      { expect(subject.occurrences_of { |e| e < 0 }).to be 0 }
    it('counts 7 positive numbers') { expect(subject.occurrences_of { |e| e > 0 }).to be 7 }
  end

  context 'with an empty collection' do
    it 'counts 0 for any empty collection' do
      [[], Set.new, {}].each do |obj|
        expect(obj.occurrences_of { true }).to be(0), "Expected to count 0, for an empty #{obj.class}"
      end
    end
  end

  it("doesn't return nil") { expect([1].occurrences_of {}).not_to be_nil }
end

describe LimitDetectors, "Using an object that doesn't respond to #inject" do
  object = Object.new
  object.extend LimitDetectors
  it "raises an exception, if it's sent #at_most" do
    expect { object.at_most?(1, &:condition?) }.to raise_exception(NoMethodError, /undefined method .inject./)
  end
end

describe 'Give a warning, if non-predicate versions are used' do
  it 'yields a warning for old-style at_most' do
    expect(Kernel).to receive(:warn).with(/'at_most'.+deprecated.+'at_most\?'/)
    [1, 2, 4, 8].at_most(2, &:even?)
  end

  it 'yields a warning for old-style at_least' do
    expect(Kernel).to receive(:warn).with(/'at_least'.+deprecated.+'at_least\?'/)
    [1, 2, 4, 8].at_least(2, &:even?)
  end
end

describe 'When the provided block raises an exception' do
  subject { [1] }

  it 'an exception in at_most? is passed up the stack' do
    expect { subject.at_most?(1) { raise ArgumentError, 'BoomError' } }.to raise_error(ArgumentError, 'BoomError')
  end

  it 'an exception in occurrences_of is passed up the stack' do
    expect { subject.occurrences_of { raise ArgumentError, 'BoomError' } }.to raise_error(ArgumentError, 'BoomError')
  end
end
