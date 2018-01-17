FROM resin/rpi-raspbian:jessie

RUN ["cross-build-start"]

# build tools and python 3.4
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	cmake \
	pkg-config \
	wget \
    unzip \
    python3 \
    python3-dev \
    gfortran

# install pip3
RUN mkdir /home/sources/ \
    && wget https://bootstrap.pypa.io/get-pip.py \
	&& python3 get-pip.py

# build and install OpenBLAS from source. By default, it will be installed into /opt/OpenBLAS
RUN cd /home/sources/ \
	&& wget -O OpenBLAS.zip http://github.com/xianyi/OpenBLAS/archive/v0.2.20.zip \
	&& unzip OpenBLAS.zip \
	&& rm OpenBLAS.zip \
    && cd /home/sources/OpenBLAS-0.2.20 \
    && make TARGET=ARMV6 \
    && make install


ENV LD_LIBRARY_PATH /opt/OpenBLAS/lib/

# build and install numpy from source

RUN cd /home/sources/ \
	&& wget -O numpy.zip https://github.com/numpy/numpy/releases/download/v1.14.0/numpy-1.14.0.zip \
	&& unzip numpy.zip \
	&& rm numpy.zip

COPY ./site.cfg /home/sources/numpy-1.14.0

RUN cd /home/sources/numpy-1.14.0 \
    && pip3 install cython \
    && python3 setup.py build --fcompiler=gnu95 \
    && python3 setup.py install


# Install dependencies for OpenCV
RUN apt-get update && apt-get install -y --no-install-recommends \
	libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev \
	libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
	libxvidcore-dev libx264-dev \
	libgtk2.0-dev libgtk-3-dev \
    libatlas-base-dev

# build and install OpenCV from source
RUN cd /home/sources/ \
	&& wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.3.0.zip \
	&& unzip opencv.zip \
	&& rm opencv.zip \
    && mkdir /home/sources/opencv-3.3.0/build \
    && cd /home/sources/opencv-3.3.0/build \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D PYTHON3_EXECUTABLE=$(which python3) \
    -D PYTHON_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -D PYTHON_INCLUDE_DIR2=$(python3 -c "from os.path import dirname; from distutils.sysconfig import get_config_h_filename; print(dirname(get_config_h_filename()))") \
    -D PYTHON_LIBRARY=$(python3 -c "from distutils.sysconfig import get_config_var;from os.path import dirname,join ; print(join(dirname(get_config_var('LIBPC')),get_config_var('LDLIBRARY')))") \
    -D PYTHON3_NUMPY_INCLUDE_DIRS=$(python3 -c "import numpy; print(numpy.get_include())") \
    -D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
    -D BUILD_EXAMPLES=OFF .. \
    && make \
    && make install \
    && make clean

# copy entry point script
COPY ./entrypoint.sh /home/sources/

RUN ["chmod", "+x", "/home/sources/entrypoint.sh"]

# Start building process
ENTRYPOINT ["/home/sources/entrypoint.sh"]

RUN ["cross-build-end"]
