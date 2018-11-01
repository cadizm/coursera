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
    if (table != sets[table].parent) {
      // path compression
      sets[table].parent = getParent(sets[table].parent);
    }
    return sets[table].parent;
  }

  void merge(int destination, int source) {
    int realDestination = getParent(destination);
    int realSource = getParent(source);
    if (realDestination == realSource) {
      return;
    }
    sets[realDestination].size += sets[realSource].size;
    sets[realSource].parent = realDestination;
    max_table_size = std::max(max_table_size, sets[realDestination].size);
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
