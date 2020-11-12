cd $HOME

export APTGETYES=--yes
PACKAGE=rai

# we mounted .ssh in the run-docker.sh to allow authorization with github
git clone git@github.com:MarcToussaint/$PACKAGE.git

cd $PACKAGE
git checkout marc

git submodule init
git submodule update

make -j1 installUbuntuAll
make -j4
#make runTests

$SHELL
