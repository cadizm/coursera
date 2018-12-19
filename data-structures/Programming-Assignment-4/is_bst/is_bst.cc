#include <algorithm>
#include <iostream>
#include <vector>

using std::cin;
using std::cout;
using std::endl;
using std::vector;

struct Node {
  int key;
  int left;
  int right;

  Node() : key(0), left(-1), right(-1) {}
  Node(int key_, int left_, int right_) :
    key(key_), left(left_), right(right_)
  {}
};

void inorder(int index, const vector<Node>& tree, vector<int>* path) {
  if (index < 0 || index >= static_cast<int>(tree.size())) {
    return;
  }

  inorder(tree[index].left, tree, path);
  path->push_back(tree[index].key);
  inorder(tree[index].right, tree, path);
}

// Because it is guaranteed that all keys in Tree tree are unique, tree
// is a BST if an in order traversal produces a path such that: the key
// at any given index i is greater than the key at index i + 1, for all
// indices i >= 0, i < n
bool IsBinarySearchTree(const vector<Node>& tree) {
  vector<int> path;
  inorder(0, tree, &path);

  for (size_t i = 0; i < path.size(); ++i) {
    size_t j = i + 1;
    if (j == 0 || j >= path.size())
      break;

    if (path[i] > path[j])
      return false;
  }

  return true;
}

int main() {
  int nodes;
  cin >> nodes;
  vector<Node> tree;
  for (int i = 0; i < nodes; ++i) {
    int key, left, right;
    cin >> key >> left >> right;
    tree.push_back(Node(key, left, right));
  }
  if (IsBinarySearchTree(tree)) {
    cout << "CORRECT" << endl;
  } else {
    cout << "INCORRECT" << endl;
  }
  return 0;
}
