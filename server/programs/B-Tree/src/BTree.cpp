#include "BTree.h"
#define DEBUG_PRINT false

BTree::BTree() {}
BTree::~BTree() {}

void BTree::assignRoot() {
    //assign root by walking up the tree
    std::shared_ptr<Node> highestNode = root;
    while (highestNode->parentNode != nullptr) {
        highestNode = highestNode->parentNode;
    }
    root = highestNode;
}

void BTree::insertIndex(int idx) {

    if (root == NULL) {
        auto leafNode = std::make_shared<LeafNode>(LeafNode());
        root = leafNode;
        root->insertIndex(idx); 
        height = 1;
    } else {  
        // leaf node to insert into is found
        findLeafNode(idx, root);
        auto leafNode = std::dynamic_pointer_cast<LeafNode>(this->leafTemp);

        if (leafNode->curCapacity == leafNode->maxCapacity)  {
            leafNode->copyUp(idx);
            assignRoot(); 
            insertIndex(idx);
            return;
        } else {
            leafNode->insertIndex(idx); 
            assignRoot();
        } 
    }
}

void BTree::findLeafNode(int idx, std::shared_ptr<Node> node) {
    if (node->isLeaf) {
        this->leafTemp = node;
        return;
    } else {
        auto internalNode = std::dynamic_pointer_cast<InternalNode>(node); 
        int vecSize = internalNode->internalVec.size(); 
        //recursively search the internal nodes        
        if (idx < internalNode->internalVec[0]->index)  {
            //index less than all index in internal
            findLeafNode(idx, internalNode->leftPointer);
 
        } else if(idx > internalNode->internalVec[vecSize-1]->index) {
            //index greater than all indexes in internal
            findLeafNode(idx, internalNode->internalVec[vecSize-1]->child);
       
        } else {
            //index somewhere in the middle of the B+ Tree 
            for (int i = 1; i < vecSize; i++) {
                if (idx < internalNode->internalVec[i]->index) {
                    //search the child of the previous index entry
                   findLeafNode(idx, internalNode->internalVec[i-1]->child);
                }
            }
        }
    }
}

void BTree::searchIndex(int idx, std::shared_ptr<Node> node) {
    if (node == nullptr) { node == root; } // override default arg

    findLeafNode(idx, node);
    auto leafNode = std::dynamic_pointer_cast<LeafNode>(this->leafTemp);

    for (auto leafIndex : leafNode->indexVec) {
        if (leafIndex == idx) {
            printf("\n --- Found index %d in leaf node: ", idx);
            leafNode->printNode(); 
            return;
        }
    }
    printf("\n --- Index: %d is not in the B+ Tree", idx);
    
    return;
}

void BTree::printTreeHelper(std::shared_ptr<Node> node, int height) {
    auto leafNode = std::dynamic_pointer_cast<LeafNode>(node);
    if (leafNode != nullptr) {
        if (leafNode->heightInTree == height) {
            leafNode->printNode();
        }
        return;
    }
    
    auto curNode = std::dynamic_pointer_cast<InternalNode>(node);
    if(curNode->heightInTree == height) {
        curNode->printNode();
    }
    printTreeHelper(curNode->leftPointer, height); 
    for (auto childNode : curNode->internalVec) {
        printTreeHelper(childNode->child, height);
    }
}

void BTree::printTree(std::shared_ptr<Node> node) {

    #if DEBUG_PRINT
        //h = 1
        auto internal = std::dynamic_pointer_cast<InternalNode>(node);
        internal->printNode(); 
        printf("\n");

        // h = 2 
        internal->leftPointer->printNode();
        for (int i = 0; i < internal->internalVec.size(); i++) {
            internal->internalVec[i]->child->printNode();
        }

        // h = 3
        for (int i = 0; i < internal->internalVec.size(); i++) {
            auto internalChild = std::dynamic_pointer_cast<InternalNode>(internal->internalVec[i]->child);
            internalChild->leftPointer->printNode();
            for (int j = 0; j < internalChild->internalVec.size(); j++) {
                internalChild->internalVec[j]->child->printNode();
            }
        }
    #endif 

    #if !DEBUG_PRINT 
    //print from top to bottom, each height on own line   
    for (int i = 5; i > 0; i--) {
        printTreeHelper(node, i);
        printf("\n");
    }
     
    #endif 
}
