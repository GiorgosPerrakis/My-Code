#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>

#include "proc-common.h"
#include "tree.h"

void fork_procs(struct tree_node *root, int *pfd)
{
        int status,value1;
        char *op="+";

        close(pfd[0]);                         // child is never going to read from father
        if(root->nr_children == 0)
        {
                value1 = atoi(root->name);
                printf("%d\n",value1);
                write(pfd[1],&value1,sizeof(int));
        }
        else
        {
                pid_t p1,p2;
                int value,value1,value2,num1,num2;
                int fd[2];
                if(pipe(fd) < 0)
                {
                        perror("pipe");
                        exit(1);
                }
                p1=fork();
                if(p1 < 0)
                {
                        perror("fork");
                        exit(1);
                }
                else if(p1 == 0)
                {
                        /*child*/
 						fork_procs(root->children,fd);
                        exit(14);
                }
                else
                {
                        /*father*/
                        p2 = fork();
                        if(p2 < 0)
                        {
                                perror("fork");
                                exit(1);
                        }
                        else if(p2 == 0)
                        {
                                /*child*/
                                fork_procs(root->children +1, fd);
                                close(fd[1]);
                                exit(14);
                        }
                        close(fd[1]);
                        read(fd[0],&num1,sizeof(int));
                        read(fd[0],&num2,sizeof(int));
                        close(fd[0]);
                        p1 = wait(&status);
                        explain_wait_status(p1, status);
                        p2 = wait(&status);
                        explain_wait_status(p2, status);
                        if(!strcmp((root->name),op))
                        {
                                /*addition*/
                                value = num1 + num2;
                        }
                        else
                        {
                                /*multiplication*/
                                value = num1 * num2;
                        }
                        printf("%d\n",value);
                        write(pfd[1],&value,sizeof(int));
                        exit(14);
                }
        }
}



int main(int argc, char *argv[])
{
        pid_t p;
        int status;
        int value;
        int fd[2];
        struct tree_node *root;

        if(argc < 2)
        {
                fprintf(stderr,"Usage: %s<tree_file.\n", argv[0]);
                exit(1);
        }
        root = get_tree_from_file(argv[1]);

        if(pipe(fd) < 0)
        {
                perror("pipe");
                exit(1);
        }
        p = fork();
        if( p < 0)
        {
                perror("fork");
                exit(1);
        }
        else if(p == 0)
        {
                fork_procs(root,fd);
                exit(1);
        }
        close(fd[1]);                    // father is never going to write
        read(fd[0],&value,sizeof(int));
        printf("%d\n",value);
        p = wait(&status);
        return 0;
}

