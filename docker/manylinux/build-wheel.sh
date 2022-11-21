cp ../build/libry.cpython-37m-x86_64-linux-gnu.so robotic/
strip --strip-unneeded robotic/libry.cpython-37m-x86_64-linux-gnu.so
emacs setup.py
python3 setup.py bdist_wheel
unzip -l ./dist/robotic-0.0.1b-cp27-cp27m-linux_x86_64.whl

for wheel in $(find . -iname "*.whl") ; do 
  mv $wheel $(echo $wheel | sed 's/-linux_/-manylinux1_/')
done

twine upload dist/*.whl
