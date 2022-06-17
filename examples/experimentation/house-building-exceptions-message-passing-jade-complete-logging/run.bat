@echo off
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v-------------
    call gradlew run --no-daemon
)
