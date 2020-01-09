#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/wait.h>

#include "tree.h"
#include "proc-common.h"
#define BUFF_SIZE 1024
#define SLEEP_CHILD 10
#define SLEEP_MAIN 3

int main(int argc, char *argv[])
{
        struct tree_node *root;

        if (argc != 2) {
                fprintf(stderr, "Usage: %s <input_tree_file>\n\n", argv[0]);
                exit(1);
        }

        root = get_tree_from_file(argv[1]);
        print_tree(root);
        return 0;
}


static void __print_tree(struct tree_node *root, int level)
{
        int i;
        for (i=0; i<level; i++)
                printf("\t");
        printf("%s\n", root->name);

        for (i=0; i < root->nr_children; i++)
        {
                __print_tree(root->children + i, level + 1);
        }
}


void print_tree(struct tree_node *root)
{
        int status;
        __print_tree(root, 0);
        pid_t p;
        p=fork();
        printf("%ld",(long)p);
        if(p < 0)
        {
                perror("fork1\n");
                exit(1);
        }
        if( p == 0 )
        {
                /*child*/
                printf("Main: Created A\n");
                proc_tree(root, 0);
                exit(14);
        }
        else
        {
                /*father*/
                printf("Main: waiting for A to terminate\n");
                sleep(SLEEP_MAIN);
                show_pstree(p);
                p=wait(&status);

        }
}


static void proc_tree(struct tree_node *root, int level)
{
        int i,status;
        change_pname(root->name);
        if(root->nr_children == 0)
        {
                printf("Child: My pid id %ld and i'm sleeping\n", (long)getpid());
                sleep(SLEEP_CHILD);
                return;
        }
        else
        {
                pid_t p[root->nr_children];
                for ( i= 0; i < root->nr_children; i++)
                {
                        p[i] = fork();
                        if(p[i] < 0)
                        {
                               perror("fork\n");
                               exit(1);
                        }
                        if( p[i] == 0)
                        {
                                  /*child*/
                                 proc_tree(root->children + i, level + 1);
                                 printf("Child: My pid is %ld and i'm exiting\n",(long)getpid());
                                 exit(14);
                        }
                        else
                        {
                                /*father*/
                                printf("Father: Created child with pid %ld and waiting for it to terminate\n", (long)p[i]);

                        }
                 }
                for(i=0; i < root->nr_children; i++)
                {
                        p[i]=wait(&status);
                }
                printf("Father: My pid is %ld and i'm exiting\n",(long)getpid());
                exit(14);
        }
}
