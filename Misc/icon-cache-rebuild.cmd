taskkill.exe /f /im explorer.exe

ping 127.0.0.1 -n 1 > nul

del %localappdata%\IconCache.db /a

ping 127.0.0.1 -n 1 > nul

start explorer.exe

pause