//Abby Alperovich
//COP 3502H
//Program 4
// 3/18/17
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// The maximum length of a player name or game name
#define LENGTH 30

typedef struct node {
	char *player;
	char *game;
	struct node *right;
	struct node *left;
} node;

// dynamically allocate space for a new node, given its data
node *create_node(char *player, char *game) {
	node *newNode = malloc(sizeof(node));
	if (newNode == NULL) {
		printf("Space was not allocated for a new node in createNode.\n");
		return NULL;
	}
	
	newNode->player = malloc(sizeof(char) * (strlen(player) + 1));
	if(newNode->player == NULL) {
		printf("Space was not allocated for the new node's player value.\n");
		free(newNode);
		return NULL;
	}
	newNode->game = malloc(sizeof(char) * (strlen(game) + 1));
	if(newNode->game == NULL) {
		printf("Space was not allocated for the new node's game value.\n");
		free(newNode->player);
		free(newNode);
		return NULL;
	}
	
	strcpy(newNode->player, player);
	strcpy(newNode->game, game);
	
	newNode->right = NULL;
	newNode->left = NULL;
	
	return newNode;
}

// free the memory associated with the BST rooted at n recursively
node *destroy_node(node *n) {
	if(n == NULL) {
		return NULL;
	}
	free(n->player);
	free(n->game);
	destroy_node(n->left);
	destroy_node(n->right);
	free(n);
	return NULL;
}

//could be iterative, but was done recursively
//returns max of right subtree
node *find_max(node *root) {
	if(root == NULL)
		return NULL;
	if(root->right != NULL)
		return find_max(root->right);
	return root;
}

//removes node and ensures nodes are reinserted as necessary to avoid orphans
node *bst_remove_node(node *root, char *name){
	//removes node and fixes tree
	node *newRoot;
	int c;
	if(root == NULL)
		return NULL;
	c = -strcmp(root->player, name);
	//printf("root is not null\n");
	if(c < 0) {
		//printf("root comes before name\n");
		root->left = bst_remove_node(root->left, name);}
	else if(c > 0){
		//printf("root comes after name\n");
		root->right = bst_remove_node(root->right, name);}
	else {
		if(root->right == NULL && root->left == NULL) {
			destroy_node(root);
			root = NULL;
		}
		else if (root->left == NULL) {
			newRoot = root->right;
			destroy_node(root);
			return newRoot;
		}
		else if(root->right ==  NULL) {
			newRoot = root->left;
			destroy_node(root);
			return newRoot;
		}
		else {
			newRoot = find_max(root->left);
			strcpy(root->player, newRoot->player);
			strcpy(root->game, newRoot->game);
			bst_remove_node(root->left, name);
		}

	}
	return root;
}

//inserts nodes by bst rules
node *bst_insert(node *root, node *newNode) {
	if(root == NULL)
		return newNode;
	//printf("inserting %s into %s\n", newNode->player, root->player);
	if(strcmp(root->player, newNode->player) < 0) {
		root->right = bst_insert(root->right, newNode);
	}
	else {
		root->left = bst_insert(root->left, newNode);
	}
	return root;
}

//inserts nodes so smaller values go right and larger go left
node *bst_inv_insert(node *root, node *newNode) {
	if(root == NULL)
		return newNode;
	if(strcmp(root->player, newNode->player) < 0) {
		root->left = bst_inv_insert(root->left, newNode);
	}
	else {
		root->right = bst_inv_insert(root->right, newNode);
	}
	return root;
}

//prints nodes via inorder traversal
void bst_print(node *root) {
	if(root == NULL)
		return;
	bst_print(root->left);
	printf("%s\t%s\n", root->player, root->game); 
	bst_print(root->right);
}

//prints players of a given game
void bst_print_game(node *root, char *game) {
	if(root == NULL)
		return;
	bst_print_game(root->left, game);
	if(strcmp(game, root->game) == 0)
		printf("%s\n", root->player);
	bst_print_game(root->right, game);
}

// returns whether or not the BSTs rooted at a/b are reflections of each other
int is_reflection(node *a, node *b) {
	if(a == NULL && b == NULL)
		return 1;
	if(a == NULL)
		return 0;
	if(b == NULL)
		return 0;
	if(strcmp(a->game, b->game) != 0)
		return 0;

	is_reflection(a->left, b->right);
	is_reflection(a->right, b->left);
	
	return is_reflection(a->left, b->right) && is_reflection(a->right, b->left);
}

int main(int argc, char **argv) {
	char buffer[LENGTH], buffer2[LENGTH];
	
	FILE *ifp;
	int numPeople, i;
	node *root = NULL, *root2 = NULL, *temp;
	
	// accepts command line argument
	if (argc < 2) {
		printf("What is the name of the file you'd like to use?\n");
		scanf("%s", buffer);
	}
	else {
		strcpy(buffer, argv[1]);
	}

	ifp = fopen(buffer, "r");
	if(ifp == NULL) {
		printf("File not found!\n");
		return 1;
	}

	//PART1
	while(1) {
		fscanf(ifp, "%s", buffer);
		//printf("current command: %s\n", buffer);

		if(strcmp(buffer, "ADD") == 0) {
			fscanf(ifp, "%s %s", buffer, buffer2);
			temp = create_node(buffer, buffer2);
			root = bst_insert(root, temp);	
		}
		else if(strcmp(buffer, "REMOVE") == 0) {
			//remove a person
			fscanf(ifp, "%s", buffer);
			printf("removing %s\n", buffer);
			root = bst_remove_node(root, buffer);
		}
		else if(strcmp(buffer, "PRINT") == 0) {
			//print each person and their game using inorder traversal
			printf("%s:\n", buffer);
			bst_print(root);
			printf("\n");
		}
		else if(strcmp(buffer, "PRINTGAME") == 0) {
			//print the game and each person who likes it, inorder traversal
			fscanf(ifp, "%s", buffer);
			printf("%s:\n", buffer);
			bst_print_game(root, buffer);
			printf("\n");
		}
		else if (strcmp(buffer, "PART2") == 0) {
			break;
		}
		else {
			printf("Unknown command: %s\n", buffer);
			return 1;
		}
	}

	printf("-PART 2-\n");

	//PART2
	fscanf(ifp, "%d", &numPeople);
	//create a new reflected tree based on the number of people
	for(i = 0; i < numPeople; i++) {
		fscanf(ifp, "%s %s", buffer, buffer2);
		temp = create_node(buffer, buffer2);
		root2 = bst_inv_insert(root2, temp);
	}
	bst_print(root2);
	if(is_reflection(root, root2))
		printf("These two groups are reflections and can meet for game night!\n");
	else
		printf("These two groups are not reflections and will not agree on a game to play.\n");
	return 0;
}