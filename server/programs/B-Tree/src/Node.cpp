#include "Node.h"

Node::Node() {}
Node::~Node() {}

/*
Leaf Node Implementation
        */
LeafNode::LeafNode() {
    curCapacity = 0;
    maxCapacity = 3;
    heightInTree = 1;
    isLeaf = true;
}

void LeafNode::copyUp(int idx) {
    // copy up index from leafnode into parent internal node
    std::shared_ptr<LeafNode> thisLeafNode = getPtr();
    std::shared_ptr<LeafNode> nextLeafNode = std::make_shared<LeafNode>(LeafNode());
    std::shared_ptr<InternalNode> internalNode = std::dynamic_pointer_cast<InternalNode>(thisLeafNode->parentNode); 

    int copyIdx = floor(maxCapacity / 2);
    int copyVal = thisLeafNode->indexVec[copyIdx];   

    if (internalNode == nullptr) { 
        //make new internal node
        internalNode = std::make_shared<InternalNode>(InternalNode()); 
        internalNode->leftPointer = thisLeafNode; 
        internalNode->heightInTree = this->heightInTree + 1;
    }    

    //Add IndexPointer node to new leaf node into internal node  
    std::shared_ptr<IndexPointerNode> copyUpNode = std::make_shared<IndexPointerNode>();
    copyUpNode->index = copyVal;
    copyUpNode->child = nextLeafNode;
    internalNode->insertIndexPointerNode(copyUpNode);   

    //remove leaf node values from [copyIdx:end]
    int curIdx = thisLeafNode->indexVec.size() - 1; //end of the vector
    while(curIdx >= copyIdx) {
        int carryIdx = thisLeafNode->indexVec[curIdx]; 
        // remove index from current leaf node and insert into new leaf node. 
        thisLeafNode->deleteIndex(carryIdx);
        nextLeafNode->insertIndex(carryIdx); 
        // decrement counters
        thisLeafNode->curCapacity--;
        curIdx--;
    }

    if (internalNode->shouldPushUp) { 
        //trigger push up on internal parent node
        int pushIdx = floor(internalNode->curCapacity / 2) -1; 
        auto pushVal = internalNode->internalVec[pushIdx];
        internalNode->pushUp(pushVal); 
        internalNode->shouldPushUp = false;
        
        thisLeafNode->nextNode = nextLeafNode;
        return;
    }

    //link to existing tree
    nextLeafNode->parentNode = internalNode;
    thisLeafNode->nextNode = nextLeafNode;
    parentNode = internalNode;
    return;

}

void LeafNode::insertIndexHelper(int idx) {
    int i = 0; 
    for(auto it=indexVec.begin() ; it < indexVec.end(); it++) {
        if (*it > idx) {
            indexVec.insert(it, idx);
            curCapacity++;
            return;
        }
    }
    indexVec.push_back(idx);
    curCapacity++;
}

void LeafNode::insertIndex(int idx) {  
    insertIndexHelper(idx);
    return; 
}

void LeafNode::deleteIndex(int idx) {
    for (auto it = indexVec.begin(); it < indexVec.end(); it++) {
        if (*it == idx) {
            indexVec.erase(it);
        }
    }
    return;
}

void LeafNode::printNode() {
    std::cout << "[ "; 
    int i = 0;
    for (auto index : indexVec) {
        std::cout << index << "*";
        if (i != indexVec.size() - 1) {
            std::cout << ", ";
        } 
        i++;
    }
    std::cout << " ]";
    std::cout << curCapacity;
}

/*
Internal Node Implementation
    */

InternalNode::InternalNode() {
    curCapacity = 0;
    maxCapacity = 3;
    isInternal = true;
}

void InternalNode::insertIndexPointerNode(std::shared_ptr<IndexPointerNode> indexPtrNode) {
    // push up if one more than max capacity (accounted for implicit first ptr)
    bool inserted = false;
    for (auto it = internalVec.begin(); it < internalVec.end(); it++) {
        if (indexPtrNode->index < (*it)->index ) {
            internalVec.insert(it, indexPtrNode);
            curCapacity++;
            inserted = true;
            break;
        }
    }
    if (!inserted) {
        internalVec.push_back(indexPtrNode);
        curCapacity++;
    }
    
    if (curCapacity == (maxCapacity + 1)) {
        this->shouldPushUp = true; 
    }
    return;
}

std::shared_ptr<IndexPointerNode> InternalNode::initIndexPointerNodeFromCopy(std::shared_ptr<IndexPointerNode> indexPtrNode) {

    auto newIndexPointerNode = std::make_shared<IndexPointerNode>();
    newIndexPointerNode->index = indexPtrNode->index;
    newIndexPointerNode->child = indexPtrNode->child;

    return newIndexPointerNode;
}

void InternalNode::pushUp(std::shared_ptr<IndexPointerNode> indexPtrNode) {

    auto thisNode = getPtr();
    auto splitNode = std::make_shared<InternalNode>(InternalNode());

    //if parent does not exist then we create
    std::shared_ptr<InternalNode> parentInternal = std::dynamic_pointer_cast<InternalNode>(thisNode->parentNode);
    if (this->parentNode == nullptr) {
        parentInternal = std::make_shared<InternalNode>(InternalNode());
        parentInternal->heightInTree = (thisNode->heightInTree + 1);
        parentInternal->leftPointer = thisNode;
    }

    //split node and this node at same height
    splitNode->heightInTree = thisNode->heightInTree;

    // copy split indexes into split node 
    bool split = false;
    for (int i = 0; i < thisNode->internalVec.size(); i++) {
        auto currentIndex = thisNode->internalVec[i];
        if (split) {            
            auto copyNode = initIndexPointerNodeFromCopy(currentIndex);
            copyNode->child->parentNode = splitNode;
            splitNode->insertIndexPointerNode(copyNode);
        }
        if (thisNode->internalVec[i]->index == indexPtrNode->index) {
            split = true;
            continue;
        } 
    } 
    //assign left pointer to the pushed up node's child 
    splitNode->leftPointer = indexPtrNode->child;    

    // remove split indexes from this node
    for (auto node : splitNode->internalVec) {
        thisNode->deleteIndexPtrNode(node->index);
    }
    thisNode->deleteIndexPtrNode(indexPtrNode->index);

    indexPtrNode->child = splitNode;
    parentInternal->insertIndexPointerNode(indexPtrNode);

    thisNode->parentNode = parentInternal;
    splitNode->parentNode = parentInternal;

    return;
}

void InternalNode::deleteIndexPtrNode(int idx) {
    auto thisNode = getPtr();
    for (int i = 0; i < thisNode->internalVec.size(); i++)  {
        auto curIdxPtr = thisNode->internalVec[i];
        if (curIdxPtr->index == idx) {
            thisNode->internalVec.erase(
                thisNode->internalVec.begin() + i
            );
            thisNode->curCapacity--;
        }
    }
    return;
} 

void InternalNode::printNode() {
    if (internalVec.size() == 0) {
        std::cout << "[ ]" << 0;

    } else if (internalVec[0]->index == 0) {
        int i = 0;
        std::cout << "[ "; 
        for (auto child : internalVec) {
            if (child->index == 0) {
                continue;
            }
            std::cout << child->index;
            if (i != internalVec.size() -2) {
                std::cout << ", ";
            } 
            i++;
        }
        std::cout << " ]"; 
        std::cout << curCapacity;
    } else {
        std::cout << "[ ";
        int i = 0;
        for (auto child : internalVec) { 
            std::cout << child->index;
            if (i != internalVec.size() -1) {
                std::cout << ", ";
            } 
            i++;
        } 
        std::cout << " ]" << " " << internalVec.size() << " ";
    }
}