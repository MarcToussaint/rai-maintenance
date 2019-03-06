## installing packages locally (~/opt) from source

OpenCV:
```
mkdir -p ~/git
cd ~/git
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd opencv
#git checkout -b 4.0.1
mkdir build
cd build
cmake \
 -DCMAKE_INSTALL_PREFIX=$HOME/opt \
 -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
 ..
#ccmake .. #deactivate some BUILD_opencv_*
make
make install
```

Bullet:
```
mkdir -p ~/git
cd ~/git https://github.com/bulletphysics/bullet3.git
cd bullet3
./build_cmake_pybullet_double.sh
```

