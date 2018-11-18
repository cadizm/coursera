#include <cstdint>
#include <cstdlib>
#include <ctime>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>

#ifdef USE_LARGEST_64BIT_PRIME_
  uint32_t SEED = time(nullptr);
  const uint64_t PRIME = 0xFFFFFFFFFFFFFFC5;
  const uint64_t RANDOM = (rand_r(&SEED) + 1) % (PRIME - 1);
#else
  const uint64_t PRIME = 1000000007;
  const uint64_t RANDOM = 1;
#endif  // USE_LARGEST_64BIT_PRIME_

uint64_t poly_hash(const std::string& s) {
  uint64_t hash = 0;

  for (int64_t i = s.size() - 1; i >= 0; --i) {
    hash = (hash * RANDOM + s[i]) % PRIME;
  }

  return hash;
}

std::vector<uint64_t> precompute_hashes(const std::string& text,
                                        const std::string& pattern) {
  std::vector<uint64_t> res;
  res.resize(text.size() - pattern.size() + 1);

  const std::string s = text.substr(text.size() - pattern.size(),
                                    pattern.size());
  res[text.size() - pattern.size()] = poly_hash(s);

  uint64_t y = 1;
  for (size_t i = 1; i <= pattern.size(); ++i) {
    y = (y * RANDOM) % PRIME;
  }

  for (int64_t i = text.size() - pattern.size() - 1; i >= 0; --i) {
    res[i] = ((((RANDOM * res[i + 1] % PRIME) + text[i]) % PRIME) -
              (y * text[i + pattern.size()] % PRIME));
  }

  return res;
}

std::vector<int> rabin_karp(const std::string& text,
                            const std::string& pattern) {
  std::vector<int> res;

  uint64_t pattern_hash = poly_hash(pattern);
  std::vector<uint64_t> hashes = precompute_hashes(text, pattern);

  for (size_t i = 0; i <= text.size() - pattern.size(); ++i) {
    if (hashes[i] != pattern_hash)
      continue;

    // don't allocate substrings
    if (memcmp(&(text.c_str()[i]), &(pattern.c_str()[0]),
               sizeof(char) * pattern.size()) == 0)
      res.push_back(i);
  }

  return res;
}

struct Data {
  std::string pattern;
  std::string text;
};

Data read_input() {
  Data data;
  std::cin >> data.pattern >> data.text;

  return data;
}

void print_occurrences(const std::vector<int>& output) {
  for (size_t i = 0; i < output.size(); ++i)
    std::cout << output[i] << " ";
  std::cout << "\n";
}

std::vector<int> get_occurrences(const Data& input) {
  return rabin_karp(input.text, input.pattern);
}


int main() {
  std::ios_base::sync_with_stdio(false);
  print_occurrences(get_occurrences(read_input()));

  return 0;
}
