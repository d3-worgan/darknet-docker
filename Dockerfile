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
