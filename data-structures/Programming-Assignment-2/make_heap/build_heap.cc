#include <iostream>
#include <vector>

class HeapBuilder {
 private:
  std::vector<int> data;
  std::vector<std::pair<int, int>> swaps;

  void WriteResponse() const {
    std::cout << swaps.size() << "\n";
    for (int i = 0; i < swaps.size(); ++i) {
      std::cout << swaps[i].first << " " << swaps[i].second << std::endl;
    }
  }

  void ReadData() {
    int n;
    std::cin >> n;
    data.resize(n);
    for (int i = 0; i < n; ++i)
      std::cin >> data[i];
  }

  // Note: Min-Heap
  void SiftDown(int i) {
    int min = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < data.size() && data[left] < data[min]) {
      min = left;
    }

    if (right < data.size() && data[right] < data[min]) {
      min = right;
    }

    if (i != min) {
      std::swap(data[i], data[min]);
      swaps.push_back(std::make_pair(i, min));
      SiftDown(min);
    }
  }

  // In-place heapify. Running time is 2n = O(n).
  void BuildHeap() {
    // We begin at index (size / 2) because all leaf nodes
    // satisfy the heap property by definition.
    //
    // We maintain the invariant that after each iteration
    // of SiftDown, the heap property is maintained at each
    // subtree rooted at index i.
    for (int i = data.size() / 2; i >= 0; --i) {
      SiftDown(i);
    }
  }

  void GenerateSwaps() {
    swaps.clear();
    BuildHeap();
  }

 public:
  void Solve() {
    ReadData();
    GenerateSwaps();
    WriteResponse();
  }
};

int main() {
  std::ios_base::sync_with_stdio(false);
  HeapBuilder heap_builder;
  heap_builder.Solve();
  return 0;
}
