require 'spec_helper'


describe 'Aray#at_most' do
  Array.send :include, LimitDetectors

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


describe 'Hash#at_most' do
  Hash.send :include, LimitDetectors
  it 'detects a condition based on key as well as value properties' do
    h = { 'foo' => 1, 'bar' => 4, 'baz' => 5, 'bum' => 1, 'fum' => 0}
    expect( h.at_most(3){|ky,vl| ky.match(/^b/) || vl > 1  }).to be_true
  end
end
