# darknet-docker
darknet in docker for easy online training and testing

## Host
Use the setup_host.sh script to make sure docker and nvidia drivers are installed

## Dockerfile
- An image with the cuda toolkit for GPU
- Downloads and builds Darknet for object object detection
- Installs some other packages for downloading datasets from open images
- Download the image from docker hub https://hub.docker.com/repository/docker/d3worgan/darknet  

## Other scripts
- Written in python and used for downloading datasets from Open Images dataset. 
- Fix the labels for YOLO format from open images.
- Run a MAP test on an detection model.

https://github.com/NVIDIA/nvidia-container-runtime  
https://github.com/NVIDIA/nvidia-docker  
https://github.com/openimages/dataset  
