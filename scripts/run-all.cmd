@echo off
cd /d D:\my_lib\2\cpp\python310

echo Running all compile scripts...

call compile-86-normal.cmd
call compile-86-server.cmd

call compile-89-normal.cmd
call compile-89-server.cmd

call compile-120-normal.cmd
call compile-120-server.cmd

call compile-all-normal.cmd
call compile-all-server.cmd

echo.
echo All compile scripts completed.
pause
