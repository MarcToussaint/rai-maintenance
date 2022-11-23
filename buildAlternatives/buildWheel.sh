cd $HOME/wheel
ln -s $HOME/local/buildAlternatives/CMakeLists-ry.txt CMakeLists.txt
make -C rai unityAll
mkdir build
cd build
cmake -DPYBIND11_PYTHON_VERSION=3.7 ..
make libry
cmake -DPYBIND11_PYTHON_VERSION=3.10 ..
make libry

#https://thomastrapp.com/posts/building-a-pypi-package-for-a-modern-cpp-project/

strip --strip-unneeded libry*37*.so
strip --strip-unneeded libry*310*.so

cd ../wheel

rm -Rf dist/ build/

rm -Rf robotic/*.so
cp ../build/libry*310*.so robotic/libry.so
python3.10 setup.py bdist_wheel 

rm -f robotic/*.so
cp ../build/libry*37*.so robotic/libry.so
python3.7 setup.py bdist_wheel 

cd dist
for wheel in $(find . -iname "*.whl") ; do 
  mv $wheel $(echo $wheel | sed 's/-linux_/-manylinux2010_/')
done

twine upload dist/*.whl

