## installing packages locally (~/opt) from source

OpenCV:
```
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

See also the [test/Core/array](https://github.com/MarcToussaint/rai/blob/master/test/Core/array/main.cpp) examples.

<img witdh="100%" id="arr syntax conventions" src="arr.svg">
