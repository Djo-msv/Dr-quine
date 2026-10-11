#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/wait.h>

int count = 5;
char *source = "#include <unistd.h>%cint main(){write(1, \"test\", 4);}";

int	main(int argc, char **argv, char **envp) {
	char pathname[32] = "Sully_";

	if (count < 0)
		exit(1);
	int i = 6;
	pathname[i++] = count + '0';
	pathname[i++] = '.';
	pathname[i++] = 'c';
	pathname[i++] = 0;
	int fd = open(pathname, O_RDWR|O_CREAT, 0777);
	if (fd < 0)
		exit(1);
	dprintf(fd, source, 10);
	close(fd);
	pid_t pid = fork();
	if (pid == 0) {
		char *args[] = {"/usr/bin/cc", pathname, NULL};
		execve("/usr/bin/cc", args, envp);
	}
	else {
		char *args[] = {"./a.out", NULL};
		wait(NULL);
		execve("./a.out", args, envp);
	}
}
