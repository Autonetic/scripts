# Thermal Reactor - GNU CPU Temperature Monitor 

## cpu-temp.sh
Simple shell script to display the current cpu temperature. featuring a time stamping function and minutely temperature updates.

## thermalReactor.sh
CPU Temperature monitoring with a thermal overheat protection function. the program will run a kill script to close all current shell terminals to free up recources and stop looping programs, such as crypto miners or tunnle terminal windows.
### To run a complete kill script:
remove the comment hash symbol on line 41 and delete or comment out line 42.
this will rung "killall5" instead of "pkill -9 bash"
