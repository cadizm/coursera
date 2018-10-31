#include <cstdint>
#include <iostream>
#include <vector>
#include <queue>

using std::vector;
using std::cin;
using std::cout;

struct Worker {
  Worker(int num, int next_free_time) :
    num(num),
    next_free_time(next_free_time)
  {}

  int num;
  int64_t next_free_time;
};

template<class T> struct WorkerCompare {
  // Use greater to make min-priority queue.
  // Workers with smaller num given priority.
  bool operator() (const T& a, const T& b) const {
    if (a.next_free_time == b.next_free_time) {
      return a.num > b.num;
    }
    return a.next_free_time > b.next_free_time;
  }
};

class JobQueue {
 private:
  int num_workers;
  vector<int> jobs;
  vector<int> assigned_workers;
  vector<int64_t> start_times;

  std::priority_queue<Worker, std::vector<Worker>, WorkerCompare<Worker>> worker_queue;

  void WriteResponse() const {
    for (int i = 0; i < jobs.size(); ++i) {
      cout << assigned_workers[i] << " " << start_times[i] << std::endl;
    }
  }

  void ReadData() {
    int m;
    cin >> num_workers >> m;
    jobs.resize(m);
    for (int i = 0; i < m; ++i)
      cin >> jobs[i];
  }

  void AssignJobs() {
    assigned_workers.resize(jobs.size());
    start_times.resize(jobs.size());

    for (int i = 0; i < num_workers; ++i) {
      worker_queue.push(Worker(i, 0));
    }

    for (int i = 0; i < jobs.size(); ++i) {
      int duration = jobs[i];

      Worker next = worker_queue.top();
      assigned_workers[i] = next.num;

      start_times[i] = next.next_free_time;
      next.next_free_time += duration;

      worker_queue.pop();
      worker_queue.push(next);
    }
  }

 public:
  void Solve() {
    ReadData();
    AssignJobs();
    WriteResponse();
  }
};

int main() {
  std::ios_base::sync_with_stdio(false);
  JobQueue job_queue;
  job_queue.Solve();

  return 0;
}
