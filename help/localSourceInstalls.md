## installing packages locally (~/opt) from source

OpenCV:
```
mkdir -p $HOME/git
mkdir -p $HOME/opt
cd $HOME/git
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd opencv
git checkout -b 4.0.1
mkdir build
cd build
cmake \
 -DCMAKE_INSTALL_PREFIX=$HOME/opt \
 -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
 ..
#ccmake .. #deactivate some BUILD_opencv_*
make -j $(command nproc)
make install
```

Bullet:
```
mkdir -p $HOME/git
mkdir -p $HOME/opt
cd $HOME/git
git clone https://github.com/bulletphysics/bullet3.git
cd bullet3
git checkout -b 2.88
mkdir -p build_cmake
cd build_cmake
cmake \
 -DCMAKE_INSTALL_PREFIX=$HOME/opt \
 -DBUILD_PYBULLET=ON \
 -DBUILD_PYBULLET_NUMPY=ON \
 -DUSE_DOUBLE_PRECISION=ON \
 -DBT_USE_EGL=ON \
 -DCMAKE_BUILD_TYPE=Release \
 ..
make -j $(command nproc)
make install
```

