#OS AND SSH CONFIG
#All passages in the README
#UPDATES
sudo apt update && sudo apt upgrade
#
#DOCKER INSTALLATION
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker pi

#PORTAINER INSTALLATION
sudo docker pull portainer/portainer:linux-arm
sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer:linux-arm

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