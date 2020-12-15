#executing without terminal emulator (nohup ./script)
killall mpv
ip="192.168.1.79"
ports=(8081)
mpv "http://$ip:${ports[@]}"
#if it stops for some reasons it restarts because we will transform it in a daemon yayyy https://stackoverflow.com/questions/19233529/run-bash-script-as-daemon 