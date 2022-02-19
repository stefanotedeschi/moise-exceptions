@echo off
cd house-building-no-exceptions-ours
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v OURS-------------
    call gradlew run --no-daemon
)
cd ..
cd house-building-no-exceptions-standard
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v STANDARD-------------
    call gradlew run --no-daemon
)