@echo off
FOR /L %%v IN (1,1,10) DO (
    echo -------------Iteration %%v-------------
    call gradlew run
)