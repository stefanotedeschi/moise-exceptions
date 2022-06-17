@echo off
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v-------------
    start gradlewrun.bat
    timeout /t 90
    Taskkill /FI "WINDOWTITLE eq gradlewrun"
)
