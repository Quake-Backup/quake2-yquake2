#!/bin/sh 

# PID of "gnome-screensaver-command -i" (if used) 
GSC_PID=0 

# if gnome-screensaver is running in the background.. 
if [ $(ps auxww | grep gnome-screensaver | wc -l) -gt 0 ]; then 
    echo "inhibiting gnome screensaver" 
    gnome-screensaver-command -i & 
    # save the PID of the last command 
    GSC_PID=$! 
fi 

# Stop unclutter
if [ $(ps auxww | grep unclutter | wc -l) -gt 0 ]; then 
	echo 'inhibiting unclutter'
	killall -STOP unclutter
fi

# run quake 2 
./quake2 $* 

# if gnome-screensaver was running.. 
if [ $GSC_PID -gt 0 ]; then 
    echo "reactivating gnome screensaver"     
    kill $GSC_PID 
fi

# Continue unclutter
if [ $(ps auxww | grep unclutter | wc -l) -gt 0 ]; then 
	echo 'reactivating unclutter'
	killall -CONT unclutter
fi
 