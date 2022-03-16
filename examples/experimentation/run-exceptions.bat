@echo off
cd house-building-exceptions-ours
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v OURS-------------
    call gradlew run --no-daemon
)
cd ..
cd house-building-exceptions-message-passing
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v MESSAGE PASSING-------------
    call gradlew run --no-daemon
)
