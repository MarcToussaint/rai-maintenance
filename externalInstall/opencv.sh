#https://docs.opencv.org/3.4/d7/d9f/tutorial_linux_install.html

sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev

cd $HOME/git
git clone git@github.com:opencv/opencv.git
cd opencv
#git checkout 3.4
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_DOCS=1 -DBUILD_EXAMPLES=1 ..
make -j4
