#include <iostream>
#include <vector>
#include <string>
#include <cassert>
#include <algorithm>

using std::cin;
using std::string;
using std::vector;
using std::cout;

class StackWithMax {
  vector<int> stack;
  vector<int> aux;

 public:
  void Push(int value) {
    stack.push_back(value);
    if (aux.empty() || value >= aux.back()) {
      aux.push_back(value);
    }
  }

  void Pop() {
    assert(stack.size());
    int value = stack.back();
    stack.pop_back();
    if (!aux.empty() && aux.back() == value) {
      aux.pop_back();
    }
  }

  int Max() const {
    assert(stack.size());
    int aux_top = aux.empty() ? 0 : aux.back();
    return std::max(stack.back(), aux_top);
  }
};

int main() {
  int num_queries = 0;
  cin >> num_queries;

  string query;
  string value;

  StackWithMax stack;

  for (int i = 0; i < num_queries; ++i) {
    cin >> query;
    if (query == "push") {
      cin >> value;
      stack.Push(std::stoi(value));
    } else if (query == "pop") {
      stack.Pop();
    } else if (query == "max") {
      cout << stack.Max() << "\n";
    } else {
      assert(0);
    }
  }
  return 0;
}
