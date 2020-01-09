#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <string.h>
#include <assert.h>
#include <stdbool.h>
#include <sys/wait.h>
#include <sys/types.h>

#include "proc-common.h"
#include "request.h"

/* Compile-time parameters. */
#define SCHED_TQ_SEC 2                /* time quantum */
#define TASK_NAME_SZ 60               /* maximum size for a task's name */

struct procs{
        int proc_id;
        pid_t proc_pid;
        struct procs *next;
};

struct procs *previous;
struct procs *pointer;
struct procs *start_list;

int nproc;

/*
 * SIGALRM handler
 */

static void sigalrm_handler(int signum)
{
        if(signum != SIGALRM)
        {
                printf("Caught wrong signal\n");
                exit(1);
        }
        else
        {
                kill(pointer->proc_pid,SIGSTOP);
        }
}

/*
 * SIGCHLD handler
 */

static void sigchld_handler(int signum)
{
        pid_t p;
        int status;
        for(;;)
        {
                if(nproc == 0)
                        exit(1);
                else
                {

                        p = waitpid(-1, &status, WUNTRACED | WNOHANG);
                        if(p < 0)
                        {
                                perror("waitpid");
                                exit(1);
                        }
                        if(p == 0)
                        {
                                break;
                        }
                        explain_wait_status(p, status);

                        if(WIFEXITED(status) || WIFSIGNALED(status))
                        {
                                /*A child has died*/
                                if(pointer->next != NULL)                             //if we are not in the last node
                                {
                                        if(pointer != start_list)                          //if we are not in the first node
                                        {
                                                previous->next = pointer->next;                //connect previous with next node
                                                free(pointer);
                                                pointer = previous->next;                     //pointer points to the next node
                                        }
                                        else                                            //if we are in the first node
                                        {
                                                start_list = pointer->next;                   //start_list points to the second node
                                                free(pointer);
                                                pointer = start_list;                         //pointer also points to the next node
                                        }
                                }
                                else if( pointer->next == NULL)                     //if we are in the last node
                                {
                                        previous->next = NULL;                            //previous points to the last node
                                        free(pointer);
                                        pointer = start_list;                             //pointer points to the first node
                                }
                                kill(pointer->proc_pid, SIGCONT);
                                nproc--;
                                alarm(SCHED_TQ_SEC);
                        }
                        else if(WIFSTOPPED(status))
                        {
                                /*A child has stopped due to SIGSTOP/SIGTSTP, etc */
                                if(pointer->next != NULL)                                    //if we are not in the last node
                                {
                                        pointer = pointer->next;                                   //pointer points to the next node
                                        if(previous->next != NULL)
                                        {
                                                previous = previous->next;                             
                                        }
                                        else
                                        {
                                                previous = start_list;
                                        }
                                }
                                else
                                {
                                        if(previous->next != NULL)
                                        {
                                                previous = previous->next;
                                        }
                                        else
                                        {
                                                previous = start_list;
                                        }
                                        pointer = start_list;
                                }
                                kill(pointer->proc_pid, SIGCONT);
                                alarm(SCHED_TQ_SEC);
                        }
                }       }
}

/* Install two signal handlers.
 * One for SIGCHLD, one for SIGALRM.
 * Make sure both signals are masked when one of them is running.
 */

static void install_signal_handlers(void)
{
        sigset_t sigset;
        struct sigaction sa;

        sa.sa_handler = sigchld_handler;
        sa.sa_flags = SA_RESTART;
        sigemptyset(&sigset);
        sigaddset(&sigset, SIGCHLD);
        sigaddset(&sigset, SIGALRM);
        sa.sa_mask = sigset;
        if (sigaction(SIGCHLD, &sa, NULL) < 0)
        {
                perror("sigaction: sigchld");
                exit(1);
        }

        sa.sa_handler = sigalrm_handler;
        if (sigaction(SIGALRM, &sa, NULL) < 0)
        {
                perror("sigaction: sigalrm");
                exit(1);
        }

        /*
         * Ignore SIGPIPE, so that write()s to pipes
         * with no reader do not result in us being killed,
         * and write() returns EPIPE instead.
         */
        if(signal(SIGPIPE, SIG_IGN) < 0)
        {
                perror("signal: sigpipe");
                exit(1);
        }
}

int main(int argc, char *argv[])
{
        /*
         * For each of argv[1] to argv[argc - 1],
         * create a new child process, add it to the process list.
         */

        int i;
        nproc = argc - 1;                       /* number of proccesses goes here */
        pid_t p[nproc];
        struct procs *root;

        char *newargv[] = { NULL, NULL, NULL, NULL };
        char *newenviron[] = { NULL };

        for( i = 0; i < nproc; i++ )
        {
                /* Creation of list*/
                if(pointer != NULL)
                {
                        root = ( struct procs * )malloc(sizeof(struct procs) );
                        pointer->next = root;
                        pointer = root;
                        pointer->next = NULL;
                }
                else
                {
                        root = ( struct procs * ) malloc(sizeof(struct procs) );
                        pointer = root;
                        previous = root;
                        start_list = root;
                }
                p[i] = fork();
                if( p[i] < 0 )
                {
                        perror("fork");
                        exit(1);
                }
                else if ( p[i] == 0 )
                {
                        /* child */
                        raise(SIGSTOP);
                        newargv[0] = argv[i+1];
                        execve(argv[i+1], newargv, newenviron);
                }
        }

        /* Wait for all children to raise SIGSTOP before exec()ing. */
        wait_for_ready_children(nproc);
        pointer = start_list;

        for( i = 0; i < nproc; i++ )
        {
                kill(p[i],SIGCONT);
                pointer->proc_pid = p[i];
                pointer->proc_id = i + 1;
                pointer = pointer->next;
        }

        wait_for_ready_children(nproc);

        /* Install SIGALRM and SIGCHLD handlers. */
        install_signal_handlers();

        pointer = start_list;
        kill(pointer->proc_pid,SIGCONT);
        alarm(SCHED_TQ_SEC);

        if (nproc == 0)
        {
                fprintf(stderr, "Scheduler: No tasks. Exiting...\n");
                exit(1);
        }


        /* loop forever  until we exit from inside a signal handler. */
        while (pause())
                ;

        /* Unreachable */
        fprintf(stderr, "Internal error: Reached unreachable point\n");
        return 1;
}
                                                    
