#include <array>     // array
#include <cstddef>   // size_t
#include <fstream>   // ifstream
#include <iostream>  // cout
#include <string>    // string, getline, stoi

constexpr std::size_t amount_of_numbers = 2'000;

int main()
{
  std::ifstream stream{"input.txt"};
  std::array<int, amount_of_numbers> numbers{};

  std::string line;
  line.reserve(20);

  std::size_t index = 0;
  while (std::getline(stream, line)) {
    numbers.at(index) = std::stoi(line);
    line.clear();
    ++index;
  }

  std::size_t count = 0;
  for (std::size_t i = 1; i < amount_of_numbers; ++i) {
    if (numbers.at(i - 1) < numbers.at(i)) {
      ++count;
    }
  }

  std::cout << "Count: " << count << "\n---\n";

  count = 0;
  for (std::size_t i = 3; i < amount_of_numbers; ++i) {
    if (numbers.at(i - 3) < numbers.at(i)) {
      ++count;
    }
  }

  std::cout << "Count: " << count << "\n";
  return 0;
}