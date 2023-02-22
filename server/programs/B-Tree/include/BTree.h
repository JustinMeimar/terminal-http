#pragma once
#include "Node.h" 

class BTree {
    public:
        int height = 0;
        int nodeCount = 0;
        std::shared_ptr<Node> root;
        std::shared_ptr<Node> leafTemp;
        BTree();
        ~BTree();

        void assignRoot();
        void searchIndex(int idx, std::shared_ptr<Node> node = nullptr);
        void findLeafNode(int idx, std::shared_ptr<Node> node = nullptr); //searchIndex && insertIndex helper
        
        void insertIndex(int idx);
        void printTree(std::shared_ptr<Node> node);
        void printTreeHelper(std::shared_ptr<Node> node, int height);
};