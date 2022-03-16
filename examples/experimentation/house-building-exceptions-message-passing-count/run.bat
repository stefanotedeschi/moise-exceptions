@echo off
FOR /L %%v IN (1,1,100) DO (
    echo -------------Iteration %%v-------------
    call gradlew run
)
