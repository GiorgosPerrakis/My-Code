#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "proc-common.h"

#define SLEEP_PROC_SEC  10
#define SLEEP_1 1
#define SLEEP_TREE_SEC  3

int main(void)
{
        pid_t p_A;
        int status;

        p_A = fork();
        if( p_A < 0 )           //main creates A
        {
                perror("main: fork");
                exit(1);
        }
        else if( p_A == 0 )
        {
                printf("A: starting\n");
                printf("A: waiting\n");
                change_pname("A");
                pid_t p_B;
                p_B = fork();
                if ( p_B < 0 )
                {
                        perror("A: fork");
                        exit(1);
                }
                else if ( p_B == 0 )
                {
                        /*B child*/
                        change_pname("B");
                        printf("B: starting\n");
                        printf("B: waiting\n");
                        pid_t p_D;
 						p_D = fork();
                        if( p_D < 0 )
                        {
                                perror("B: fork");
                                exit(1);
                        }
                        else if(p_D == 0)
                        {
                                /*child D*/
                                change_pname("D");
                                printf("D: starting\n");
                                printf("D: sleeping\n");
                                sleep(SLEEP_PROC_SEC);
                                printf("D: exiting\n");
                                exit(13);
                        }
                        sleep(SLEEP_1);
                        printf("B: waiting for D to exit\n");
                        p_B = wait(&status);                   //B waits D
                        explain_wait_status(p_B, status);
                        exit(19);
                }
                else
                {
                        sleep(SLEEP_1);
                        printf("A: waiting for B to exit\n");
                        pid_t p_C;
                        p_C = fork();
                        if(p_C < 0)
                        {
                                perror("A: fork");
                                exit(1);
                        }
                        else if( p_C == 0)
                        {
                                /*C child*/
                                change_pname("C");
                                printf("C: starting\n");
                                printf("C: sleeping\n");
                                sleep(SLEEP_PROC_SEC);
                                printf("C: exiting\n");
                                exit(17);
                        }
 						sleep(SLEEP_1);
                        printf("A: waiting for C to exit\n");
                        p_C = wait(&status);                    //A waits C
                        explain_wait_status(p_C, status);
                }
                p_B = wait(&status);                    //A waits B
                explain_wait_status(p_B, status);
                printf("A: exiting\n");
                exit(16);

        }
        sleep(SLEEP_TREE_SEC);

        show_pstree(p_A);                  /* Print the process tree root at pid */
        p_A = wait(&status);
        explain_wait_status(p_A, status);

        return 0;
}
           
