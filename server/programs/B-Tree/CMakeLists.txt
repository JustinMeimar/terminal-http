cmake_minimum_required(VERSION 3.10)

project(btree)

include_directories(
    "./include"
)

set (btree_src_files
    "./src/main.cpp"
    "./src/Node.cpp"
    "./src/BTree.cpp"
)  

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ../bin)

add_executable(btree ${btree_src_files})
