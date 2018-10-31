#include <algorithm>
#include <iostream>
#include <vector>
#if defined(__unix__) || defined(__APPLE__)
#include <sys/resource.h>
#endif

class Node;
int height(Node* node);

class Node {
 public:
  int key;
  Node* parent;
  std::vector<Node*> children;

  Node() {
    this->parent = nullptr;
  }

  void setParent(Node* theParent) {
    parent = theParent;
    parent->children.push_back(this);
  }
};


int main_with_large_stack_space() {
  std::ios_base::sync_with_stdio(0);
  int n;
  std::cin >> n;

  Node* root = nullptr;
  std::vector<Node> nodes;
  nodes.resize(n);

  for (int child_index = 0; child_index < n; child_index++) {
    int parent_index;
    std::cin >> parent_index;
    if (parent_index >= 0) {
      nodes[child_index].setParent(&nodes[parent_index]);
    } else {
      root = &nodes[child_index];
    }
    nodes[child_index].key = child_index;
  }

  if (root != nullptr) {
    std::cout << height(root) << std::endl;
  }

  return 0;
}

int height(Node* node) {
  if (node == nullptr) {
    return 0;
  }

  if (node->children.empty()) {
    return 1;
  }

  std::vector<int> child_heights(node->children.size());

  for (unsigned int i = 0; i < child_heights.size(); ++i) {
    child_heights[i] = height(node->children[i]);
  }

  return 1 + *std::max_element(child_heights.begin(), child_heights.end());
}

int main() {
#if defined(__unix__) || defined(__APPLE__)
  // Allow larger stack space
  const rlim_t kStackSize = 16 * 1024 * 1024;   // min stack size = 16 MB
  struct rlimit rl;
  int result;

  result = getrlimit(RLIMIT_STACK, &rl);
  if (result == 0) {
    if (rl.rlim_cur < kStackSize) {
      rl.rlim_cur = kStackSize;
      result = setrlimit(RLIMIT_STACK, &rl);
      if (result != 0) {
        std::cerr << "setrlimit returned result = " << result << std::endl;
      }
    }
  }

#endif
  return main_with_large_stack_space();
}
