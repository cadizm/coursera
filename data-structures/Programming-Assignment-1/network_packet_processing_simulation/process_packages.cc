#include <iostream>
#include <deque>
#include <vector>

struct Request {
  Request(int arrival_time, int process_time):
    arrival_time(arrival_time),
    process_time(process_time)
  {}

  int arrival_time;
  int process_time;
};

struct Response {
  Response(bool dropped, int start_time):
    dropped(dropped),
    start_time(start_time)
  {}

  bool dropped;
  int start_time;
};

class Buffer {
 public:
  explicit Buffer(int size):
    size(size),
    finish_time()
  {}

  Response Process(const Request &request) {
    // go through buffer and remove finished jobs
    while (!finish_time.empty() &&
           finish_time.front() <= request.arrival_time) {
      finish_time.erase(finish_time.begin());
    }

    // buffer full
    if (static_cast<int>(finish_time.size()) == size) {
      return Response(true, -1);
    }

    // add job to buffer
    int start_time = finish_time.empty() ?
                     request.arrival_time : finish_time.back();
    finish_time.push_back(start_time + request.process_time);

    return Response(false, start_time);
  }

 private:
  int size;
  std::deque<int> finish_time;
};

std::vector<Request> ReadRequests() {
  std::vector<Request> requests;
  int count;
  std::cin >> count;
  for (int i = 0; i < count; ++i) {
    int arrival_time, process_time;
    std::cin >> arrival_time >> process_time;
    requests.push_back(Request(arrival_time, process_time));
  }
  return requests;
}

std::vector<Response> ProcessRequests(const std::vector<Request> &requests,
                                      Buffer *buffer) {
  std::vector<Response> responses;
  for (unsigned int i = 0; i < requests.size(); ++i)
    responses.push_back(buffer->Process(requests[i]));
  return responses;
}

void PrintResponses(const std::vector<Response> &responses) {
  for (unsigned int i = 0; i < responses.size(); ++i)
    std::cout << (responses[i].dropped ?
                  -1 :
                  responses[i].start_time) << std::endl;
}

int main() {
  int size;
  std::cin >> size;
  std::vector<Request> requests = ReadRequests();

  Buffer buffer(size);
  std::vector<Response> responses = ProcessRequests(requests, &buffer);

  PrintResponses(responses);

  return 0;
}
