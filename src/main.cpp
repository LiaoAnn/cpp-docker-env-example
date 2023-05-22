#include <iostream>
#include <boost/filesystem.hpp>

namespace fs = boost::filesystem;

int main() {
    fs::path path("~/");

    if (fs::exists(path) && fs::is_directory(path)) {
        std::cout << "Directory exists!" << std::endl;

        // Iterate over the files in the directory
        for (const auto& entry : fs::directory_iterator(path)) {
            std::cout << entry.path().filename() << std::endl;
        }
    } else {
        std::cout << "Directory does not exist!" << std::endl;
    }

    return 0;
}
