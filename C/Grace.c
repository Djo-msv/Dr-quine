#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define FILE char *file = "Grace_kid.c";
#define SOURCE char *source = "#include <stdio.h>%c#include <fcntl.h>%c#include <unistd.h>%c%c#define FILE char *file = %c%s%c;%c#define SOURCE char *source = %c%s%c;%c#define PROGRAM int main(){int fd = open(file, O_RDWR | O_CREAT, 0777);dprintf(fd, source, 10, 10, 10, 10, 34, file, 34, 10, 34, source, 34, 10, 10, 10, 10, 10, 10, 10);close(fd);}%c%c// no main here%cFILE%cSOURCE%cPROGRAM%c";
#define PROGRAM int main(){int fd = open(file, O_RDWR | O_CREAT, 0777);dprintf(fd, source, 10, 10, 10, 10, 34, file, 34, 10, 34, source, 34, 10, 10, 10, 10, 10, 10, 10);close(fd);}

// no main here
FILE
SOURCE
PROGRAM
