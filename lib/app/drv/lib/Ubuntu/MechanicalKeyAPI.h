int MechanicalKeyPortOpen(const char *pathName, unsigned long *fds);
int MechanicalKeyPortClose(long fds);
int MechanicalKeyEventRcv(unsigned long *fds, const char *pathName);
