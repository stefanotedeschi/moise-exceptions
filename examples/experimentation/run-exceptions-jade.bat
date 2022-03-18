@echo off
cd house-building-exceptions-ours-jade
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v OURS JADE-------------
    call gradlew run --no-daemon
)
cd ..
cd house-building-exceptions-message-passing-jade
FOR /L %%v IN (1,1,1000) DO (
    echo -------------Iteration %%v MESSAGE PASSING JADE-------------
    call gradlew run --no-daemon
)
