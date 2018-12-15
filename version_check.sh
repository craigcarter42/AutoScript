#!/usr/bin/env bash
local_version=0
remote_version=""
auth_check="auth256"
count=0

# Download Version check file.
v_check=`curl -s "https://gist.githubusercontent.com/craigcarter42/e9b41d3eb135c39ff8ea832daeb26a91/raw/7264f901ad1391c46143a05daa34256939e285d9/launchctr_version"`
final_check=$v_check

echo " -- Launch Control Version Check: Start"

for final_check in $final_check
do
  	if [ $count == "0" ]; then
	  	if [ "$final_check" == "$auth_check" ]; then
	  		echo " -- auth_check:      PASS"
	  	else
	  		echo " -- auth_check:      FAILED"
	  		echo " -- auth_check:      EXIT"
	  		exit
	  	fi
		count=$((count+1))
	fi

	if [ "$final_check" == "2" ]; then
  		remote_version=$final_check
  	fi
done

echo " -- Local Version:  " $local_version
echo " -- Remote Version: " $remote_version

if [ $local_version -eq $remote_version ]; then
	echo " -- New Version:     NO"
	# RUN NEXT SCRIPT
fi

if [ $local_version -lt $remote_version ]; then
	echo " -- New Version:     YES"
	echo " -- New Version:     Auto Update: RUN"
	curl -s "https://gist.githubusercontent.com/craigcarter42/b7bd01d87d1bdbec3e7dbb15b406fab0/raw/d19cfbbe981b2c57408d744129341050fd68276b/fake_program.command" > fake_program.command
	chmod +x fake_program.command
	echo " -- launchctr:       RUN"
	echo ""
	sh fake_program.command
	echo ""
	echo " -- launchctr:       mv to final"
	mv fake_program.command launchctr.command
	# RUN NEXT SCRIPT
fi

if [ $local_version -gt $remote_version ]; then
	echo " -- New Version:     Nice Delorean, time traveler"
fi

echo " -- Launch Control Version Check: End"











