#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>

int function(char *source_file, char *destination_file);

int main(int argc, char *argv[])
{
	if(argc == 1 | argc == 2)
	{
		printf("Usage: ./fconc infile1,infile2 [outfile (default:fconc.out)]");
		exit(21);
	}
    else if(argc == 3)
	{
		function(argv[1],"fconc.out");	
		function(argv[2],"fconc.out");		
	}
	else if(argc == 4)
	{
   	    function(argv[1],argv[3]); 		
		function(argv[2],argv[3]);    
	}
	    
    return 0;
}



int function(char *source_file, char *destination_file)
{
	char buff[1024];
	ssize_t rcnt, wcnt;              //number of bytes returned by read() and write()
	size_t len, idx;
	int input_fd, output_fd;          //input and output file descriptors
	
	int fd, oflags, mode;
    oflags = O_WRONLY | O_CREAT;
    mode = S_IRUSR | S_IWUSR;
	
	output_fd = open(destination_file, oflags, mode);
	close(output_fd);
	
	
	input_fd = open(source_file, O_RDONLY);
		
	if(input_fd == -1)
	{
		perror("open");
		return 2;
	}
	
	oflags = O_WRONLY | O_APPEND | O_CREAT;
	
	output_fd = open(destination_file, oflags, mode);
	
	if(output_fd == -1)
	{
		perror("open");
		return 3;
	}
			
    for(;;)
    {
    	rcnt = read(input_fd, buff, 1024);
    	if(rcnt == 0) 
    		return 0;
    	if(rcnt == -1)
		{
			perror("read");
			return 4;
		}    
		idx = 0;
		len = strlen(buff);
		do
		{
			wcnt = write(output_fd, buff + idx, len - idx);
			if(wcnt == -1)
			{
				perror("write");
				return 5;
			}
			idx += wcnt;
		} while ( idx < len);    
	}
	
	close(input_fd);
	close(output_fd);
	return (EXIT_SUCCESS);
}

