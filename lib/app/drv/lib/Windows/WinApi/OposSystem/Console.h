#pragma once

class Console
{
public:
    Console()
    {
        AllocConsole();
        freopen_s(&m_fp, "CONOUT$", "w", stdout);
        freopen_s(&m_fp, "CONIN$", "r", stdin);
    }

    ~Console()
    {
        fclose(m_fp);
    }

private:
    FILE* m_fp;
};