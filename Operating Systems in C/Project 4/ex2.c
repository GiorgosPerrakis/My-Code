#includen<errno.h>
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
#define SHELL_EXECUTABLE_NAME "shell" /* executable for shell */

struct procs{
        int proc_id;
        pid_t proc_pid;
        char *name;
        struct procs *next;
};

struct procs *root;
struct procs *previous;
struct procs *pointer;
struct procs *start_list;
struct procs *last_p;
struct procs *print_p;
struct procs *temp_p;

int nproc;

/* Print a list of all tasks currently being scheduled.  */
static void sched_print_tasks(void)
{
        printf("Process that is currently running: %d\n", pointer->proc_id);
        print_p = start_list;
        while(print_p->next != NULL)
        {
                printf("Process id: %d\n", print_p->proc_id);
                printf("Process pid: %d\n", print_p->proc_pid);
                if(print_p->proc_id != 0)
                        printf("Process name: %s\n", print_p->name);
                else
                        printf("Process name: %s\n", print_p->name);
                print_p = print_p->next;
        }
        printf("Process id: %d\n", print_p->proc_id);
        printf("Process pid: %d\n", print_p->proc_pid);
        if(print_p->proc_id != 0)
                printf("Process name: %s\n", print_p->name);
        else
                printf("Process name: %s\n", print_p->name);
        print_p = start_list;
}





/* Send SIGKILL to a task determined by the value of its
 * scheduler-specific id.
 */
static int sched_kill_task_by_id(int id)
{
        print_p = start_list;
        bool flag3 = true;
        while(print_p->proc_id != id)
        {
                print_p = print_p->next;
                if(flag3 == true)
                {
                        temp_p = start_list;
                        flag3 = false;
                }
                else
                        temp_p = temp_p->next;
        }

        kill(print_p->proc_pid, SIGTERM);
        nproc--;

        temp_p->next = print_p->next;
        if(print_p == previous)
        {
                previous = temp_p;
        }
        if(print_p == pointer)
        {
                pointer = print_p->next;
        }

        free(print_p);
        print_p = start_list;
        return 1;
}


/* Create a new task */
static void sched_create_task(char *executable)
{
        pid_t p;
        char *newargv[] = { NULL, NULL, NULL, NULL };
        char *newenviron[] = { NULL };
        int temp;

        newargv[0] = executable;

        p = fork();
        if( p < 0 )
        {
                perror("fork");
                exit(1);
        }
        else if ( p == 0 )
                execve(executable, newargv, newenviron);

        root = ( struct procs * )malloc(sizeof(struct procs) );
        last_p->next = root;
        previous = root;
        temp = last_p->proc_id;
        last_p = root;
        last_p->next = NULL;

        last_p->proc_id = temp + 1;
        last_p->name = executable;
        last_p->proc_pid = p;
        nproc++;
}


/* Process requests by the shell */
static int process_request(struct request_struct *rq)
{
        switch (rq->request_no)
        {
                case REQ_PRINT_TASKS:
                        sched_print_tasks();
                        return 0;

                case REQ_KILL_TASK:
                        return sched_kill_task_by_id(rq->task_arg);

                case REQ_EXEC_TASK:
                        sched_create_task(rq->exec_task_arg);
                        return 0;

                default:
                        return -ENOSYS;
        }
}

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
                                        last_p = previous;
                                        previous->next = NULL;                            //previous points to the last node
                                        free(pointer);
                                        pointer = start_list;                             //pointer points to the first node
                                }
                                kill(pointer->proc_pid, SIGCONT);
                                alarm(SCHED_TQ_SEC);
                                nproc--;
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



/* Disable delivery of SIGALRM and SIGCHLD. */
static void signals_disable(void)
{
        sigset_t sigset;

        sigemptyset(&sigset);
        sigaddset(&sigset, SIGALRM);
        sigaddset(&sigset, SIGCHLD);
        if (sigprocmask(SIG_BLOCK, &sigset, NULL) < 0) {
                perror("signals_disable: sigprocmask");
                exit(1);
        }
}

/* Enable delivery of SIGALRM and SIGCHLD.  */
static void signals_enable(void)
{
        sigset_t sigset;

        sigemptyset(&sigset);
        sigaddset(&sigset, SIGALRM);
        sigaddset(&sigset, SIGCHLD);
        if (sigprocmask(SIG_UNBLOCK, &sigset, NULL) < 0) {
                perror("signals_enable: sigprocmask");
                exit(1);
        }
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
        if (sigaction(SIGCHLD, &sa, NULL) < 0) {
                perror("sigaction: sigchld");
                exit(1);
        }

        sa.sa_handler = sigalrm_handler;
        if (sigaction(SIGALRM, &sa, NULL) < 0) {
                perror("sigaction: sigalrm");
                exit(1);
        }

        /*
         * Ignore SIGPIPE, so that write()s to pipes
         * with no reader do not result in us being killed,
         * and write() returns EPIPE instead.
         */
        if (signal(SIGPIPE, SIG_IGN) < 0) {
                perror("signal: sigpipe");
                exit(1);
        }
}

static void do_shell(char *executable, int wfd, int rfd)
{
        char arg1[10], arg2[10];
        char *newargv[] = { executable, NULL, NULL, NULL };
        char *newenviron[] = { NULL };

        sprintf(arg1, "%05d", wfd);
        sprintf(arg2, "%05d", rfd);
        newargv[1] = arg1;
        newargv[2] = arg2;

        raise(SIGSTOP);
        execve(executable, newargv, newenviron);

        /* execve() only returns on error */
        perror("scheduler: child: execve");
        exit(1);
}

/* Create a new shell task.
 *
 * The shell gets special treatment:
 * two pipes are created for communication and passed
 * as command-line arguments to the executable.
 */
static void sched_create_shell(char *executable, int *request_fd, int *return_fd)
{
        pid_t p;
        int pfds_rq[2], pfds_ret[2];

        if (pipe(pfds_rq) < 0 || pipe(pfds_ret) < 0) {
                perror("pipe");
                exit(1);
        }

        p = fork();
        if (p < 0) {
                perror("scheduler: fork");
                exit(1);
        }

        if (p == 0) {
                /* Child */
                close(pfds_rq[0]);
                close(pfds_ret[1]);
                do_shell(executable, pfds_rq[1], pfds_ret[0]);
                assert(0);
        }
        /* Parent */
        close(pfds_rq[1]);
        close(pfds_ret[0]);
        *request_fd = pfds_rq[0];
        *return_fd = pfds_ret[1];

        root = ( struct procs * )malloc(sizeof(struct procs) );
        pointer = root;
        start_list=root;
        previous=root;
        pointer->next = NULL;

        pointer->proc_id = 0;
        pointer->proc_pid = p;
        pointer->name = executable;
}

static void shell_request_loop(int request_fd, int return_fd)
{
        int ret;
        struct request_struct rq;

        /*
         * Keep receiving requests from the shell.
         */
        for (;;)
        {
                if (read(request_fd, &rq, sizeof(rq)) != sizeof(rq))
                {
                        perror("scheduler: read from shell");
                        fprintf(stderr, "Scheduler: giving up on shell request processing.\n");
                        break;
                }

                signals_disable();
                ret = process_request(&rq);
                signals_enable();

                if (write(return_fd, &ret, sizeof(ret)) != sizeof(ret))
                {
                        perror("scheduler: write to shell");
                        fprintf(stderr, "Scheduler: giving up on shell request processing.\n");
                        break;
                }
        }
}

int main(int argc, char *argv[])
{
        int i;
        /* Two file descriptors for communication with the shell */
        static int request_fd, return_fd;


        /* Create the shell. */
        sched_create_shell(SHELL_EXECUTABLE_NAME, &request_fd, &return_fd);

        /* TODO: add the shell to the scheduler's tasks */

        /*
         * For each of argv[1] to argv[argc - 1],
         * create a new child process, add it to the process list.
         */

        nproc = argc - 1;           /* number of proccesses goes here */
        pid_t p[nproc];

        char *newargv[] = { NULL, NULL, NULL, NULL };
        char *newenviron[] = { NULL };

        for( i = 0; i < nproc; i++ )
        {
                /* Creation of list*/
                root = ( struct procs * )malloc(sizeof(struct procs) );
                pointer->next = root;
                pointer = root;
                pointer->next = NULL;

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

        last_p = pointer;
        pointer = start_list->next;

        for( i = 0; i < nproc; i++ )
        {
                kill(p[i],SIGCONT);
                pointer->proc_pid = p[i];
                pointer->proc_id = i + 1;
                pointer->name = argv[i+1];
                pointer = pointer->next;
        }

        wait_for_ready_children(nproc);

        /* Install SIGALRM and SIGCHLD handlers. */
        install_signal_handlers();

        pointer = start_list;
        previous = start_list;
        pointer = pointer->next;
        kill(pointer->proc_pid,SIGCONT);
        alarm(SCHED_TQ_SEC);

        if (nproc == 0) {
                fprintf(stderr, "Scheduler: No tasks. Exiting...\n");
                exit(1);
        }

        shell_request_loop(request_fd, return_fd);

        /* Now that the shell is gone, just loop forever
         * until we exit from inside a signal handler.
         */
        while (pause())
                ;

        /* Unreachable */
        fprintf(stderr, "Internal error: Reached unreachable point\n");
        return 1;
}

