#include <stdio.h>
#include <stdlib.h>

int	main(int argc, char **argv) {
	FILE *stream;
	char *line = NULL;
	size_t size = 0;
	ssize_t nread;

	stream = fopen(argv[1], "r");
	while ((nread = getline(&line, &size, stream)) != -1) {
		for (ssize_t i = 0; i != nread; i++) {
			printf("0x%02x, ", line[i]);
		}
	}
}
