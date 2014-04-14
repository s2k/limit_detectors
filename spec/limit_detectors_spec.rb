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

end
