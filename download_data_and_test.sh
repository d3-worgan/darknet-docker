# Download the open images image urls and descrtiptions
cd /home/darknet/data/oi_map_test/
wget https://storage.googleapis.com/openimages/2018_04/class-descriptions-boxable.csv && \
wget https://storage.googleapis.com/openimages/2018_04/test/test-annotations-bbox.csv && \
# wget https://storage.googleapis.com/openimages/2018_04/validation/validation-annotations-bbox.csv && \

# Download some images and their labels from Open Images 
pwd && ls && python3 download-multi-together.py --mode test --classes classes.txt

# Fix the labels for YOLO format and make a list of paths for darknet to find them
python3 fix_oi_labels.py -d /home/darknet/data/oi_map_test/test/ && python3 make-darknet-jpg-paths.py -d /home/darknet/data/oi_map_test/test/ -t test_set.txt

# Point darknet to the right dataset
cd /home/darknet/cfg/
sed -i 's#valid = data/coco_val_5k.list#valid = /home/darknet/data/oi_map_test/test_set.txt#g' openimages.data

# Download the weights for the detection model
cd /home/darknet/
wget https://pjreddie.com/media/files/yolov3-openimages.weights

# Calculate the MAP of the detector and save the results to a text file
./darknet detector map '/cfg/openimages.data' 'cfg/yolov3-openimages.cfg' 'yolov3-openimages.weights' > /home/darknet/data/oi_map_test/test_results.txt

# Save the results to the github repo
git add .
git commit -m "completed map job"
git push origin master