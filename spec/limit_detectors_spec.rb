require 'spec_helper'

Array.send :include, LimitDetectors

describe '#at_most' do

  it 'is true for an empty Array' do
    expect([].at_most(5){ true }).to be_true
  end

  it 'is true if the criterion is met once' do
    expect(["it's there"].at_most(1){ |el| el == "it's there"}).to be_true
  end

  it 'is true if all elements meet the criterion and the size is the given maximum number' do
    expect([1,1,1].at_most(3){|e| e == 1})
  end

  it 'is false if not enough elements meet the criterion' do
    expect([1, 2, 4].at_most(1){|e| e.even?}).to be_false
  end

  it 'is true if 0 elements are expected to match' do
    r = Array.new(10){rand}
    expect(r.at_most(0){ |i| i > 2 }).to be_true
  end

  describe 'Hash#at_most' do
    Hash.send :include, LimitDetectors
    it 'detects a condition based on key as well as value properties' do
      h = { 'foo' => 1, 'bar' => 4, 'baz' => 5, 'bum' => 1, 'fum' => 0}
      expect( h.at_most(3){|ky,vl| ky.match(/^b/) || vl > 1  }).to be_true
    end
  end

end

describe '#at_least' do
  it 'is false for an empty Array' do
    expect([].at_least(1){ true }).to be_false
    expect([].at_least(1){ false }).to be_false
  end

  it 'is true if the expected number is 0 and Array is empty' do
    expect([].at_least(0){ true }).to be_true
    expect([].at_least(0){ false }).to be_true
  end

  it 'is false if the container ist smaller than the expected number' do
    size = 10
    expect(Array.new(10).at_least(size + 1){true}).to be_false
  end

  it 'is true if the criterion is met and expected once' do
    expect(["it's there"].at_least(1){ |el| el == "it's there"}).to be_true
  end

  it 'is true if all elements meet the criterion and the size is the given minimum number' do
    expect([1,1,1].at_least(3){|e| e == 1}).to be_true
  end

  it 'is true if enough elements meet the criterion' do
    expect([1, 2, 4, 8].at_least(2){|e| e.even?}).to be_true
  end

  it 'is true if there are enough elements to match' do
    r = Array.new(10){|i|i}
    expect(r.at_least(7){ |i| i > 2 }).to be_true
    expect(r.at_least(8){ |i| i > 2 }).to be_false
  end

end

describe 'Using an object that doesn\'t respond to #inject will raise an exception' do
  object = Object.new
  object.extend LimitDetectors
  it 'will raise an exception, if it\'s sent #atmost' do
    expect{ object.at_most(1){ |el| el.condition? } }.to raise_exception(NoMethodError, /undefined method .inject./)
  end
end
