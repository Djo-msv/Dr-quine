#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/wait.h>

int count = 2;
char *source = "#include <stdio.h>%c#include <stdlib.h>%c#include <fcntl.h>%c#include <unistd.h>%c#include <sys/wait.h>%c%cint count = %d;%cchar *source = %c%s%c;%c%cint main(int argc, char **argv, char **envp) {%c%c(void)argc;%c%c(void)argv;%c%cchar pathname[32] = %cSully_%c;%c%cchar filename[32] = %c./Sully_%c;%c%c%cif (count < 0)%c%c%cexit(1);%c%cint i = 6;%c%cpathname[i++] = count - 1 + '0';%c%cpathname[i++] = '.';%c%cfilename[i] = count - 1 + '0';%c%cpathname[i++] = 'c';%c%cfilename[i] = 0;%c%cpathname[i++] = 0;%c%cint fd = open(pathname, O_RDWR|O_CREAT, 0777);%c%cif (fd < 0)%c%c%cexit(1);%c%cdprintf(fd, source, 10, 10, 10, 10, 10, 10, count - 1, 10, 34, source, 34, 10, 10, 10, 9, 10, 9, 10, 9, 34, 34, 10, 9, 34, 34, 10, 10, 9, 10, 9, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 9, 34, 34, 34, 34, 10, 9, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 9, 10, 9, 9, 10, 9, 10, 9, 10, 10);%c%cclose(fd);%c%cpid_t pid = fork();%c%cif (pid == 0) {%c%c%cchar *args[] = {%c/usr/bin/cc%c, pathname, %c-o%c, &(filename[2]), NULL};%c%c%cexecve(args[0], args, envp);%c%c}%c%cwait(NULL);%c%cpid = fork();%c%cif (pid == 0) {%c%c%cchar *args[] = {filename, NULL};%c%c%cexecve(args[0], args, envp);%c%c}%c%cwait(NULL);%c}%c";

int main(int argc, char **argv, char **envp) {
	(void)argc;
	(void)argv;
	char pathname[32] = "Sully_";
	char filename[32] = "./Sully_";

	if (count < 0)
		exit(1);
	int i = 6;
	pathname[i++] = count - 1 + '0';
	pathname[i++] = '.';
	filename[i] = count - 1 + '0';
	pathname[i++] = 'c';
	filename[i] = 0;
	pathname[i++] = 0;
	int fd = open(pathname, O_RDWR|O_CREAT, 0777);
	if (fd < 0)
		exit(1);
	dprintf(fd, source, 10, 10, 10, 10, 10, 10, count - 1, 10, 34, source, 34, 10, 10, 10, 9, 10, 9, 10, 9, 34, 34, 10, 9, 34, 34, 10, 10, 9, 10, 9, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 9, 34, 34, 34, 34, 10, 9, 9, 10, 9, 10, 9, 10, 9, 10, 9, 10, 9, 9, 10, 9, 9, 10, 9, 10, 9, 10, 10);
	close(fd);
	pid_t pid = fork();
	if (pid == 0) {
		char *args[] = {"/usr/bin/cc", pathname, "-o", &(filename[2]), NULL};
		execve(args[0], args, envp);
	}
	wait(NULL);
	pid = fork();
	if (pid == 0) {
		char *args[] = {filename, NULL};
		execve(args[0], args, envp);
	}
	wait(NULL);
}
