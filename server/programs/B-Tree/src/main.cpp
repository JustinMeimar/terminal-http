#include <iostream>
#include <sstream>
#include "BTree.h"

int NUM_INSERTS = 10;    	

void genRandomInserts(int* inserts) {
    for (int i = 0; i < NUM_INSERTS; i++) {
        //gen random index 
        int random = (rand() % 99) + 1;
        
        //scan for duplicate 
        bool duplicate = false; 
        for (int j = 0; j < NUM_INSERTS; j++) {
            if (*(inserts + j) == random) {
                duplicate = true;
            }
        }
        if (duplicate) {
            i--;
            continue;
        }
        *(inserts + i) = random;
    }
}

int main(int argc, char** argv) {

    std::shared_ptr<BTree> tree = std::make_shared<BTree>(BTree());
    tree->root = NULL;   
    tree->nodeCount++;

    srand((unsigned) time(NULL));
    int* inserts = (int*)malloc(sizeof(int) * NUM_INSERTS);

    if (argc == 1)  { 
        int explicit_inserts[NUM_INSERTS] = { 1,2,3,4,5,6,7,8,9,10 };
        for (int i = 0; i < NUM_INSERTS; i++) {
            inserts[i] = explicit_inserts[i];
        }
    } else {
        char switch_flag = *(argv[1]);
        char flag_char = *(argv[1] + 1);

        switch (flag_char) {
            case 'r': 
                genRandomInserts(inserts); 
                break; 
            case 'h': 
                printf("\nB+ Tree\n-r   random index generation\n-h   help page\n\n");
                return 0;
            default: printf("Invalid flag\n");
        } 
    }
 
    for (int i = 0; i < NUM_INSERTS; i++) {
        
        printf("\n---- INSERTING %d -----", inserts[i]);
        tree->insertIndex(inserts[i]);    
        tree->printTree(tree->root);
    }

    free(inserts);

    return 0;
}