mkdir bin\windows
gcc -c -fpic test.c
gcc -shared test.o -o bin\windows\test.dll

pause

