#include <stdio.h>
#include <fcntl.h>

#define FILE char *file = "Grace_kid.c";
#define SOURCE char *source = "#include <stdio.h>%c#include <fcntl.h>%c%c#define FILE char *file = %c%s%c;%c#define SOURCE char *source = %c%s%c;%c#define PROGRAM int main(){int fd = open(file, O_RDWR | O_CREAT);dprintf(fd, source, 10, 10, 10, 34, file, 34, 10, 34, source, 34, 10, 10, 10, 10, 10, 10, 10);}%c%c// no main here%cFILE%cSOURCE%cPROGRAM%c";
#define PROGRAM int main(){int fd = open(file, O_RDWR | O_CREAT);dprintf(fd, source, 10, 10, 10, 34, file, 34, 10, 34, source, 34, 10, 10, 10, 10, 10, 10, 10);}

// no main here
FILE
SOURCE
PROGRAM
