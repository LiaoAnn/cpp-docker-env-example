cmake_minimum_required(VERSION 3.12)
project(MyProject)

# 指定 Boost 庫的位置
set(Boost_INCLUDE_DIR /usr/include)
set(Boost_LIBRARY_DIR /usr/lib)

# 添加 Boost 的庫和頭文件的搜索路徑
link_directories(${Boost_LIBRARY_DIR})
include_directories(${Boost_INCLUDE_DIR})

# 設置項目的可執行文件
add_executable(myapp "")

# 遞歸搜索並收集所有 .cpp 和 .h 文件
file(GLOB_RECURSE CPP_SOURCES "src/*.cpp")
file(GLOB_RECURSE HEADER_FILES "include/*.h")

# 添加所有的 .cpp 和 .h 文件到可執行文件中
target_sources(myapp PRIVATE ${CPP_SOURCES} ${HEADER_FILES})

# 鏈接 Boost 庫
target_link_libraries(myapp PRIVATE ${Boost_LIBRARIES})
