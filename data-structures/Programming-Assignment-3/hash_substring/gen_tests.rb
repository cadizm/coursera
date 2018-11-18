
def random_string(corpus, size)
  size.times.map {|_| corpus.sample }.join('')
end

MAX_LEN = 5 * 10**5
CORPUS = ('a'..'z').to_a + ('A'..'Z').to_a

def test_case
  prng = Random.new
  pattern = random_string(CORPUS, [5, prng.rand(30)].max)

  text = ''
  while text.size < prng.rand(MAX_LEN)
    flag = prng.rand(MAX_LEN) % 2 == 0 ? true : false
    if flag
      text << pattern
    else
      text << random_string(CORPUS, prng.rand(pattern.size))
    end
  end

  [pattern, text]
end


1000.times do |i|
  pattern, text = test_case
  File.open("t#{i.to_s.rjust(3, '0')}", 'w') do |f|
    f.puts pattern
    f.puts text
  end
end
