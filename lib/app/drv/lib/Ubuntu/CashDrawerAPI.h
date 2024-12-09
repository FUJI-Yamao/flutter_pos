int DrwPortOpen(const char *pathName, long *fds);
int DrwPortClose(long fds);
int DrwOpenCmd(long fds);
int DrwStatusCheck(unsigned char drwStatus1, unsigned char drwStatus2,
					char *newDrwStatus1, char *newDrwStatus2);
