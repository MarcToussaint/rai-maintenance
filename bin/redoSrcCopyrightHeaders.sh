cd ../rai

headache -h ../bin/redoSrcCopyrightHeaders.header -c ../bin/redoSrcCopyrightHeaders.conf \
src/*/*.h src/*/*.cpp src/*/*.ipp src/*/*.cxx \
src/*/retired/*.h src/*/retired/*.cpp src/*/retired/*.cxx

find . \( -name '*.h' -or -name '*.cpp' -or -name '*.ipp' -or -name '*.cxx' \) -exec ../bin/redoSrcCopyrightHeaders.filter.sh {} \;

