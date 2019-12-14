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

PhysX:
```
mkdir -p $HOME/git
cd $HOME/git
git clone https://github.com/NVIDIAGameWorks/PhysX.git
cd PhysX
git checkout 3.4
cd PhysX_3.4/Source/compiler/linux64
make release

mkdir -p $HOME/opt/physx3.4/lib
mkdir -p $HOME/opt/physx3.4/include/physx
cd $HOME/git/PhysX
cp PhysX_3.4/Bin/linux64/* $HOME/opt/physx3.4/lib
cp PhysX_3.4/Lib/linux64/* $HOME/opt/physx3.4/lib
cp PxShared/bin/linux64/* $HOME/opt/physx3.4/lib
cp -R PhysX_3.4/Include/* $HOME/opt/physx3.4/include/physx
cp -R PxShared/include/* $HOME/opt/physx3.4/include/physx

# to save disk space, delete the repo again
# rm -Rf $HOME/git/PhysX
```

```
mkdir -p $HOME/git
mkdir -p $HOME/opt
cd $HOME/git
git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
mkdir -p build
cd build
cmake \
 -DCMAKE_INSTALL_PREFIX=$HOME/opt \
 -DCMAKE_BUILD_TYPE=Release \
 ..
make -j $(command nproc)
make install
```

OMPL:

sudo apt-get install libboost-filesystem-dev libboost-system-dev libboost-program-options-dev libboost-serialization-dev

sudo apt-get libfcl-dev
