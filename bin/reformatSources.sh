cd ../rai

astyle --options=../bin/reformatSources.conf \
src/*/*.h src/*/*.cpp src/*/*.ipp src/*/*.cxx \
src/*/retired/*.h src/*/retired/*.cpp src/*/retired/*.cxx
