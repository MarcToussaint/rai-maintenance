
#export DISPLAY=:0
cd $HOME
#apt-get --yes update
#apt-get --yes install git sudo make nano

export APTGETYES=--yes
PACKAGE=KOMO

git clone https://github.com/MarcToussaint/$PACKAGE.git
# git clone git@github.com:MarcToussaint/$PACKAGE.git

cd $PACKAGE
sed 's/git@github\.com:MarcToussaint/https:\/\/github\.com\/MarcToussaint/g' .gitmodules > tmp
mv tmp .gitmodules
git submodule init
git submodule update

cp config.mk rai/build/config.mk
make initUbuntuPackages
make
make runTests

$SHELL
