# Motion Eye installation script on docker
## What this script does

### Initial requirements
- Raspberry pi (I use the 4 with 2 gigs of RAM)<br />
- SD card (at least 16 gb, I used a 64 one just because)<br />
- A monitor (at least to setup your ssh service, then you can detach it*)<br />
- Internet connection<br />

*if you don't want to setup ssh for this installation you could avoid raspi-config's option 5 and the login with ssh. In this case you must have a monitor attached to the pi. 

### OS and ssh configuration
#### (manual operations, not automated in the script)
Flash raspberry pi os (32-bit) and run it<br />

#### Execute this and use the GUI
sudo raspi-config {option 1: change user pi $password,<br />
                   option 5: enable ssh (2),<br />
                  }<br />

#### From terminal
Run "ifconfig" and note somewhere your IP (I used LAN connection to avoid headaches)<br />

ssh into pi@previous-noted-ip<br />
Insert password to log in.<br />

## Here starts the script
### Updates
sudo apt update && sudo apt upgrade

### Docker installation
curl -sSL https://get.docker.com | sh<br />
sudo usermod -aG docker pi<br />

### Portainer installation
docker pull portainer/portainer:linux-arm<br />
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer:linux-arm<br />

### Motioneyeos container installation
docker pull ccrisan/motioneye:master-armhf<br />
docker run --name="motioneye" \<br />
    -p 8765:8765 -p 8081:8081 \ <- you could change these ports as you want if you encounter problems<br />
    --hostname="motioneye" \<br />
    -v /etc/localtime:/etc/localtime:ro \<br />
    -v /etc/motioneye:/etc/motioneye \<br />
    -v /var/lib/motioneye:/var/lib/motioneye \<br />
    --restart="always" \<br />
    --detach=true \<br />
    ccrisan/motioneye:master-armhf<br />

### Managing motioneyeos
Go to your Raspberry's ip specifing port 8765 (or a different one if you changed in the installation) (ex: 192.168.238:9000) and log in as admin without password.<br />
Change your admin password from the dashboard and set a new user to just monitor the cameras.<br />

### Managing container from Portainer GUI interface
Just go to your Raspberry's ip specifing port 9000 (or a different one if you changed in the installation) (ex: 192.168.238:9000) and log into portainer.