sudo apt-get update

# Install nvidia GPU driver
sudo apt-get install ubuntu-drivers-common
sudo ubuntu-drivers autoinstall

# Restart for drivers to work
sudo poweroff

# Install docker
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Install nvidia docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker

# Download container
sudo docker pull d3worgan/darknet:1.1

