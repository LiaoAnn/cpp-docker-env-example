cmake_minimum_required(VERSION 3.12)
project(MyProject)

find_package(Boost REQUIRED COMPONENTS system filesystem)

# 設置項目的可執行文件
add_executable(myapp "")

# 遞歸搜索並收集所有 .cpp 和 .h 文件
file(GLOB_RECURSE CPP_SOURCES "src/*.cpp")
file(GLOB_RECURSE HEADER_FILES "include/*.h")

# 添加所有的 .cpp 和 .h 文件到可執行文件中
target_sources(myapp PRIVATE ${CPP_SOURCES} ${HEADER_FILES})

# 設置項目的頭文件
target_include_directories(myapp PRIVATE include)

# 添加 WebSocketpp 的頭文件路徑
target_include_directories(myapp PRIVATE /usr/include/websocketpp)

# 鏈接 Boost 庫
target_link_libraries(myapp PRIVATE Boost::system Boost::filesystem)
