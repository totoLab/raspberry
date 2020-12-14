#OS AND SSH CONFIG
#All passages in the README
#UPDATES
sudo apt update && sudo apt upgrade
echo "Updates finished" && echo
#DOCKER INSTALLATION
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker pi
echo "Docker installation finished" && echo
#PORTAINER INSTALLATION
sudo docker pull portainer/portainer:linux-arm
sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer:linux-arm
echo "Portainer installation finished" && echo
#MOTIONEYEOS CONTAINER INSTALLATION
sudo docker pull ccrisan/motioneye:master-armhf
sudo docker run --name="motioneye" \
    -p 8765:8765 -p 8081:8081 \
    --hostname="motioneye" \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/motioneye:/etc/motioneye \
    -v /var/lib/motioneye:/var/lib/motioneye \
    --restart="always" \
    --detach=true \
    ccrisan/motioneye:master-armhf

echo "MotionEyeOs container deployment finished"
echo "Installation finished. Check the setup your host machine's ip at port 9000."
