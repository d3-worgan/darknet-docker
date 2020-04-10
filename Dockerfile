FROM nvidia/cuda

# Need some stuff for downloading the dataset
RUN apt-get update && \
    apt-get install -y git curl python3-distutils wget gcc g++ gnupg2

WORKDIR /home/

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    pip install tqdm && \
    pip install awscli

###  DARKNET INSTALL  ###
RUN git clone https://github.com/AlexeyAB/darknet.git && \
	cd darknet && \
	sed -i 's/GPU=0/GPU=1/g' Makefile && \
	# sed -i 's/OPENCV=0/OPENCV=1/g' Makefile && \
	make

WORKDIR /home/darknet/data/oi_map_test/

COPY download-multi-together.py fix_oi_labels.py make-darknet-jpg-paths.py classes.txt ./

RUN wget https://storage.googleapis.com/openimages/2018_04/class-descriptions-boxable.csv && \
    wget https://storage.googleapis.com/openimages/2018_04/test/test-annotations-bbox.csv && \
    wget https://storage.googleapis.com/openimages/2018_04/validation/validation-annotations-bbox.csv && \
    echo "done"

RUN pwd && ls && python3 download-multi-together.py --mode validation --classes classes.txt

RUN wget https://pjreddie.com/media/files/yolov3-openimages.weights

RUN python3 fix_oi_labels.py -d /home/darknet/data/oi_map_test/validation/ && \
    python3 make-darknet-jpg-paths.py -d /home/darknet/data/oi_map_test/validation/ -t test_set.txt

WORKDIR /home/darknet/cfg/

RUN sed -i 's#valid = data/coco_val_5k.list#valid = /home/darknet/data/oi_map_test/test_set.txt#g' openimages.data

WORKDIR /home/darknet/
RUN ./darknet detector map '/cfg/openimages.data' 'cfg/yolov3-openimages.cfg' '/home/darknet/data/oi_map_test/yolov3-openimages.weights'