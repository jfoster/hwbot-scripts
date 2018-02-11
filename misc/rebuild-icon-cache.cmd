taskkill.exe /f /im explorer.exe

ping 127.0.0.1 -n 2 > nul

del %localappdata%\IconCache.db /a

ping 127.0.0.1 -n 2 > nul

start explorer.exe

pause