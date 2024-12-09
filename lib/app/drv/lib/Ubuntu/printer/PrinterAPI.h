int PrinterPortOpen(SIIAPIHANDLE handle, const char *devicePath);
int PrinterPortClose(SIIAPIHANDLE handle);
int PrinterWriteDevice(SIIAPIHANDLE handle, char *writebuf, size_t bufSize, size_t *writeSize);
int PrinterReadDevice(SIIAPIHANDLE handle, char *readbuf, size_t bufSize, size_t *readSize);
int PrinterGetStatus(SIIAPIHANDLE handle);
int PrinterPortReset(SIIAPIHANDLE handle);
