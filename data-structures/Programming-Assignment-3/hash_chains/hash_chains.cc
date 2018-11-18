#include <cstdint>
#include <iostream>
#include <string>
#include <list>
#include <vector>

using std::string;
using std::vector;
using std::cin;

struct Query {
  string type, s;
  size_t index;
};

class QueryProcessor {
  int bucket_count;
  vector<std::list<string>*> elems;

  size_t hash_func(const string& s) const {
    static const size_t multiplier = 263;
    static const size_t prime = 1000000007;
    uint64_t hash = 0;
    for (int i = static_cast<int> (s.size()) - 1; i >= 0; --i)
      hash = (hash * multiplier + s[i]) % prime;
    return hash % bucket_count;
  }

 public:
  explicit QueryProcessor(int bucket_count) : bucket_count(bucket_count) {
    elems.resize(bucket_count);
    for (auto it = elems.begin(); it != elems.end(); ++it) {
      *it = new std::list<string>;
    }
  }

  ~QueryProcessor() {
    for (auto it = elems.begin(); it != elems.end(); ++it) {
      delete *it;
    }
  }

  Query readQuery() const {
    Query query;
    cin >> query.type;
    if (query.type != "check")
      cin >> query.s;
    else
      cin >> query.index;
    return query;
  }

  void writeSearchResult(bool found) const {
    std::cout << (found ? "yes\n" : "no\n");
  }

  void processQuery(const Query& query) {
    if (query.type == "check") {
      std::list<string>* bucket = elems[query.index];
      for (auto it = bucket->begin(); it != bucket->end(); ++it) {
        std::cout << *it << " ";
      }
      std:: cout << std::endl;
    } else {
      std::list<string>* bucket = elems[hash_func(query.s)];

      bool found = false;
      std::list<string>::iterator it;
      for (it = bucket->begin(); it != bucket->end(); ++it) {
        if (*it == query.s) {
          found = true;
          break;
        }
      }

      if (query.type == "find") {
        writeSearchResult(found);
      } else if (query.type == "add") {
        if (!found)
          bucket->push_front(query.s);
      } else if (query.type == "del") {
        if (found)
          bucket->erase(it);
      }
    }
  }

  void processQueries() {
    int n;
    cin >> n;
    for (int i = 0; i < n; ++i)
      processQuery(readQuery());
  }
};

int main() {
  std::ios_base::sync_with_stdio(false);
  int bucket_count;
  cin >> bucket_count;
  QueryProcessor proc(bucket_count);
  proc.processQueries();
  return 0;
}
