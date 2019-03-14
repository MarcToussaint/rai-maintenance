cd $HOME

export APTGETYES=--yes
PACKAGE=rai

# we mounted .ssh in the run-docker.sh to allow authorization with github
git clone git@github.com:MarcToussaint/$PACKAGE.git

cd $PACKAGE
#sed 's/git@github\.com:MarcToussaint/https:\/\/github\.com\/MarcToussaint/g' .gitmodules > tmp
#mv tmp .gitmodules
git submodule init
git submodule update

make -j1 initUbuntuPackages
make -j4
make runTests

$SHELL
