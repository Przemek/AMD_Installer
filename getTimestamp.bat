@echo off
setlocal

FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET B=%%A
echo|set /p="%B:~0,4%-%B:~4,2%-%B:~6,2% %time:~-11,2%:%time:~-8,2%:%time:~-5,2% -> " 