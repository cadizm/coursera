#include <algorithm>
#include <iostream>
#include <vector>

using std::cin;
using std::cout;
using std::endl;
using std::vector;
using std::pair;
using std::make_pair;

struct Node {
  int key;
  int left;
  int right;

  Node() : key(0), left(-1), right(-1) {}
  Node(int key_, int left_, int right_) :
    key(key_), left(left_), right(right_)
  {}
};

void inorder(int index, const vector<Node>& tree,
             vector<pair<Node, int>>* path) {
  if (index < 0 || index >= static_cast<int>(tree.size())) {
    return;
  }

  inorder(tree[index].left, tree, path);
  path->push_back(make_pair(tree[index], index));
  inorder(tree[index].right, tree, path);
}

bool IsBinarySearchTree(const vector<Node>& tree) {
  vector<pair<Node, int>> path;
  inorder(0, tree, &path);

  // first pass over inorder path
  for (size_t i = 0; i < path.size(); ++i) {
    size_t j = i + 1;
    if (j == 0 || j >= path.size())
      break;

    if (path[i].first.key > path[j].first.key)
      return false;
  }

  // look for runs of duplicates
  vector<pair<int, int>> dups;
  for (size_t i = 0; i < path.size(); ++i) {
    size_t j = i + 1;
    if (j == 0 || j >= path.size())
      break;

    if (path[i].first.key == path[j].first.key) {
      int begin = i;
      int leftmost_index = path[begin].second;
      while (j < path.size() && path[i].first.key == path[j].first.key) {
        ++i;
        ++j;
      }
      int end = j;

      vector<pair<Node, int>> path;
      inorder(leftmost_index, tree, &path);

      int dup_count = 0;
      for (size_t k = 0; k < path.size(); ++k) {
        if (path[k].first.key == path[begin].first.key)
          dup_count++;
      }

      if (dup_count != end - begin)
        return false;
    }
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
