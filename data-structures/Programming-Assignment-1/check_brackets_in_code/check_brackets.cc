// First priority is to find the first unmatched closing bracket which either
// doesn’t have an opening bracket before it, like ] in ](), or closes the
// wrong opening bracket, like } in ()[}. If there are no such mistakes, then
// it should find the first unmatched opening bracket without the corresponding
// closing bracket after it, like ( in {}([]. If there are no mistakes, text
// editor should inform the user that the usage of brackets is correct.

#include <iostream>
#include <stack>
#include <string>

struct Bracket {
  Bracket(): position(-1) {}
  Bracket(char type, int position): type(type), position(position) {}

  bool Matchc(char c) {
    if (type == '[' && c == ']')
      return true;
    if (type == '{' && c == '}')
      return true;
    if (type == '(' && c == ')')
      return true;
    return false;
  }

  char type;
  int position;
};

int main() {
  std::string text;
  getline(std::cin, text);

  std::stack <Bracket> opening_brackets_stack;
  for (unsigned int position = 1; position <= text.length(); ++position) {
    char next = text[position - 1];  // we started at position=1

    if (next == '(' || next == '[' || next == '{') {
      opening_brackets_stack.push(Bracket(next, position));
    }

    if (next == ')' || next == ']' || next == '}') {
      Bracket top;

      if (!opening_brackets_stack.empty()) {
        top = opening_brackets_stack.top();
      }

      if (top.position == -1 || !top.Matchc(next)) {
        std::cout << position;
        return -1;
      }

      opening_brackets_stack.pop();
    }
  }

  if (!opening_brackets_stack.empty()) {
    std::cout << opening_brackets_stack.top().position;
    return -1;
  }

  std::cout << "Success";
  return 0;
}
