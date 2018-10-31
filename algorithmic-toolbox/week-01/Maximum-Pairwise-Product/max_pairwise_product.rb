
def read_input
  ARGF.gets  # discard
  ARGF.gets.split.map { |x| x.to_i }
end

def max_pairwise_product(arr)
  arr.sort.last(2).reduce(:*)
end

if __FILE__ == $0
  arr = read_input
  puts max_pairwise_product(arr)
end
