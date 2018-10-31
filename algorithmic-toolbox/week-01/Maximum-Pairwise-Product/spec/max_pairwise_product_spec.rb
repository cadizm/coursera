
require_relative '../max_pairwise_product.rb'

describe "Sample 1:" do
  arr = [1, 2, 3]
  it "#{arr}" do
    expect(max_pairwise_product(arr)).to eql(6)
  end
end

describe "Sample 2:" do
  arr = [7, 5, 14, 2, 8, 8, 10, 1, 2, 3]
  it "#{arr}" do
    expect(max_pairwise_product(arr)).to eql(140)
  end
end

describe "Sample 3:" do
  arr = [4, 6, 2, 6, 1]
  it "#{arr}" do
    expect(max_pairwise_product(arr)).to eql(36)
  end
end
