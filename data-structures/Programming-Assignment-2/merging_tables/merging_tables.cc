#include <vector>
#include <iostream>

struct DisjointSetsElement {
  int size, parent, rank;

  explicit DisjointSetsElement(int size = 0, int parent = -1, int rank = 0) :
    size(size), parent(parent), rank(rank)
  {}
};

struct DisjointSets {
  int size;
  int max_table_size;
  std::vector<DisjointSetsElement> sets;

  explicit DisjointSets(int size) :
    size(size), max_table_size(0), sets(size) {
    for (int i = 0; i < size; i++)
      sets[i].parent = i;
  }

  int getParent(int table) {
    // find parent and compress path
    return table;
  }

  void merge(int destination, int source) {
    int realDestination = getParent(destination);
    int realSource = getParent(source);
    if (realDestination != realSource) {
      // merge two components
      // use union by rank heuristic
      // update max_table_size
    }
  }
};

int main() {
  int n, m;
  std::cin >> n >> m;

  DisjointSets tables(n);
  for (auto &table : tables.sets) {
    std::cin >> table.size;
    tables.max_table_size = std::max(tables.max_table_size, table.size);
  }

  for (int i = 0; i < m; i++) {
    int destination, source;
    std::cin >> destination >> source;
    --destination;
    --source;

    tables.merge(destination, source);
    std::cout << tables.max_table_size << std::endl;
  }

  return 0;
}
