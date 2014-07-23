require 'spec_helper'
require 'set'

Array.send :include, LimitDetectors

describe '#at_most' do

  it 'is true for an empty Array' do
    expect(Kernel).to_not receive(:warn)
    expect([].at_most?(5){ true }).to be_truthy
    expect([].at_most?(0){ true }).to be_truthy
    expect([].at_most?(1){ true }).to be_truthy
    expect([].at_most?(5){ :foo }).to be_truthy
  end

  it 'is true if the criterion is met once' do
    expect(["it's there"].at_most?(1){ |el| el == "it's there"}).to be_truthy
  end

  it 'is true if all elements meet the criterion and the size is the given maximum number' do
    expect([1,1,1].at_most?(3){|e| e == 1})
  end

  it 'is false if not enough elements meet the criterion' do
    expect([1, 2, 4].at_most?(1){|e| e.even?}).to be_falsey
  end

  it 'is true if 0 elements are expected to match' do
    r = Array.new(10){rand}
    expect(r.at_most?(0){ |i| i > 2 }).to be_truthy
  end

  describe 'Hash#at_most' do
    Hash.send :include, LimitDetectors
    it 'detects a condition based on key as well as value properties' do
      h = { 'foo' => 1, 'bar' => 4, 'baz' => 5, 'bum' => 1, 'fum' => 0}
      expect( h.at_most?(3){|ky,vl| ky.match(/^b/) || vl > 1  }).to be_truthy
    end
  end

end

describe '#at_least' do

  it 'is false for an empty Array, if at least one is expected' do
    expect(Kernel).to_not receive(:warn)
    expect([].at_least?(1){ true }).to be_falsey
  end

  it 'is true if the expected number is 0 and Array is empty' do
    expect([].at_least?(0){ true }).to be_truthy
    expect({}.at_least?(0){ false }).to be_truthy
  end

  it 'is false if the container ist smaller than the expected number' do
    size = 10
    expect(Array.new(10).at_least?(size + 1){true}).to be_falsey
  end

  it 'is true if the criterion is met and expected once' do
    expect(["it's there"].at_least?(1){ |el| el == "it's there"}).to be_truthy
  end

  it 'is false for an empty Array if you expect at leat 1' do
    expect([].at_least?(1){ true }).to be_falsey
  end

  it 'is true for an empty Array if you expect at leat 0' do
    expect([].at_least?(0){  }).to be_truthy
  end

  it 'is true if the criterion is met once' do
    expect(["it's there"].at_least?(1){ |el| el == "it's there"}).to be_truthy
  end

  it 'is true if all elements meet the criterion and the size is the given minimum number' do
    expect([1,1,1].at_least?(3){|e| e == 1}).to be_truthy
  end

  it 'is true if enough elements meet the criterion' do
    expect([1, 2, 4, 8].at_least?(2){|e| e.even?}).to be_truthy
  end

  it 'is true if there are enough elements to match' do
    r = Array.new(10){|i|i}
    expect(r.at_least?(7){ |i| i > 2 }).to be_truthy
    expect(r.at_least?(8){ |i| i > 2 }).to be_falsey
  end

end

describe '#ocurrences_of' do
  context 'collection with content' do
    Set.send :include, LimitDetectors
    subject{ Set.new( [1, 2, 3, 4, 5, 6, 7]) }

    it('counts 3 even numbers')     { expect( subject.ocurrences_of &:even?).to     be 3 }
    it('counts 4 odd numbers')      { expect( subject.ocurrences_of &:odd?).to      be 4 }
    it('counts no number < 0')      { expect( subject.ocurrences_of{ |e| e < 0}).to be 0 }
    it('counts 7 positive numbers') { expect( subject.ocurrences_of{ |e| e > 0}).to be 7 }
  end

  context 'empty collection' do
    it 'counts 0 for any empty collection' do
      [[], Set.new, {}].each do | obj |
        expect(obj.ocurrences_of {true}).to be(0), "Expected to count 0, for an empty #{obj.class}"
      end
    end
  end

  it('doen\'t return nil') { expect([1].ocurrences_of {}).not_to be_nil }
end


describe 'Using an object that doesn\'t respond to #inject will raise an exception' do
  object = Object.new
  object.extend LimitDetectors
  it 'will raise an exception, if it\'s sent #atmost' do
    expect{ object.at_most?(1){ |el| el.condition? } }.to raise_exception(NoMethodError, /undefined method .inject./)
  end
end

describe 'Give a warning, if non-predicate versions are used' do
  it 'yields a warning for old-style at_most' do
    expect(Kernel).to receive(:warn).with(/'at_most'.+deprecated.+'at_most\?'/)
    [1,2,4,8].at_most(2) {|e| e.even?}
  end

  it 'yields a warning for old-style at_least' do
    expect(Kernel).to receive(:warn).with(/'at_least'.+deprecated.+'at_least\?'/)
    [1,2,4,8].at_least(2) {|e| e.even?}
  end
  end

describe 'When the provided block raises an exception' do
  subject{ [1] }
  it 'passes up the stack unchanged' do
    expect{ subject.at_most?(1) { raise ArgumentError, 'BoomError' } }.to raise_error(ArgumentError, 'BoomError')
    expect{ subject.ocurrences_of { raise ArgumentError, 'BoomError'} }.to raise_error(ArgumentError, 'BoomError')
  end
end
