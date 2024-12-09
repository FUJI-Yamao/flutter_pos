#include <stdio.h>
#include <unistd.h>
#include "test.h"

int main()
{
	printf("実行結果: %d", ExecuteTest(1));
	sleep(3);
	return 0;
}

int ExecuteTest(int arg)
{
	return arg + 1;
}

int GetCallback(int (*callback)(void*, int), int arg)
{
    return callback(NULL, arg);
}