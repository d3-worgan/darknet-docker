cd /home/darknet/data/oi_map_test/
wget https://storage.googleapis.com/openimages/2018_04/class-descriptions-boxable.csv && \
wget https://storage.googleapis.com/openimages/2018_04/test/test-annotations-bbox.csv && \
wget https://storage.googleapis.com/openimages/2018_04/validation/validation-annotations-bbox.csv && \

pwd && ls && python3 download-multi-together.py --mode validation --classes classes.txt

wget https://pjreddie.com/media/files/yolov3-openimages.weights

python3 fix_oi_labels.py -d /home/darknet/data/oi_map_test/validation/ &&python3 make-darknet-jpg-paths.py -d /home/darknet/data/oi_map_test/validation/ -t test_set.txt

cd /home/darknet/cfg/

sed -i 's#valid = data/coco_val_5k.list#valid = /home/darknet/data/oi_map_test/test_set.txt#g' openimages.data

cd /home/darknet/
./darknet detector map '/cfg/openimages.data' 'cfg/yolov3-openimages.cfg' '/home/darknet/data/oi_map_test/yolov3-openimages.weights' > /home/darknet/data/oi_map_test/test_results.txt

