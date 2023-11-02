#include <fstream>
#include <iostream>
#include <string>

int main(int argc, char *argv[]) {
  if (argc == 2) {
    std::ifstream in(argv[1], std::ios::in);
    if (!in.is_open()) {
      std::cout << "No file" << std::endl;
    }
    for (std::string line; std::getline(in, line);) {
      std::cout << line << std::endl;
    }
    in.close();
  } else {
    std::cout << "Wrong parameters" << std::endl;
  }

  int z = 0;
  while (z != 'q') {
    z = getchar();
    std::cout << z << " " << (int)'q' << std::endl;
  }
  return 0;
}
