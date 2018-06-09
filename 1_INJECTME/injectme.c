#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char *sc = "ifconfig %s"; //| grep 'inet addr:' | cut -d: -f2 | awk '{print $1}'";

int main()
{
	char buf[100];
	char input[100];
	setvbuf(stdout, 0, 1, 0);
	printf("Usage : input network_name => (ens33 / eth0)\n");
	scanf("%20s", input);
	sprintf(buf, sc, input);
	system(buf);
}

