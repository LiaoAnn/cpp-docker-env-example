cmake_minimum_required(VERSION 3.12)
project(MyProject)

# 設置項目的可執行文件
add_executable(myapp "")

# 遞歸搜索並收集所有 .cpp 和 .h 文件
file(GLOB_RECURSE CPP_SOURCES "src/*.cpp")
file(GLOB_RECURSE HEADER_FILES "include/*.h")

# 添加所有的 .cpp 和 .h 文件到可執行文件中
target_sources(myapp PRIVATE ${CPP_SOURCES} ${HEADER_FILES})

# 設置項目的頭文件
target_include_directories(myapp PRIVATE include)

# 選取多個子資料夾
file(GLOB SUBDIRECTORIES "lib/*")

# 添加子目錄
foreach(subdir ${SUBDIRECTORIES})
    if(IS_DIRECTORY ${subdir})
        add_subdirectory(${subdir})
    endif()
endforeach()

# 選取多個庫
file(GLOB LIBRARIES "lib/*/lib*.a")

# 鏈接庫
foreach(lib ${LIBRARIES})
    target_link_libraries(myapp
        PRIVATE
        ${lib}
    )
endforeach()
