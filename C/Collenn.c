#include<stdio.h>

char	n = '\n';
char	t = '\t';
char	escape = '\\';
char	quote = '\"';
char	*text = "#include<stdio.h>%c%cchar%cn = '%cn';%cchar%ct = '%ct';%cchar%cescape = '%c%c';%cchar%cquote = '%c%c';%cchar%c*text = %c%s%c;%c%c// comment present outside of the program%cvoid%cdoStuf(void){%c%cfor (int i = 0; i != 100; i++){};%c}%c%cint%cmain(){%c%c// comment present inside the main function%c%cdoStuf();%c%cprintf(text, n, n, t, escape, n, t, escape, n, t, escape, escape, n, t, escape, quote, n, t, quote, text, quote, n, n, n, t, n, t, n, n, n, t, n, t, n, t, n, t, n, n);%c}%c";

// comment present outside of the program
void	doStuf(void){
	for (int i = 0; i != 100; i++){};
}

int	main(){
	// comment present inside the main function
	doStuf();
	printf(text, n, n, t, escape, n, t, escape, n, t, escape, escape, n, t, escape, quote, n, t, quote, text, quote, n, n, n, t, n, t, n, n, n, t, n, t, n, t, n, t, n, n);
}
