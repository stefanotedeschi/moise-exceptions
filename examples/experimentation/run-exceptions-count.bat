@echo off
cd house-building-exceptions-ours-count
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v OURS-------------
    call gradlew run --no-daemon
)
cd ..
cd house-building-exceptions-message-passing-count
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v MESSAGE PASSING-------------
    call gradlew run --no-daemon
)
