cd ../rai

headache -h ../bin/redoSrcCopyrightHeaders.header -c ../bin/redoSrcCopyrightHeaders.conf \
rai/*/*.h rai/*/*.cpp rai/*/*.tpp rai/*/*.cxx \
rai/*/retired/*.h rai/*/retired/*.cpp rai/*/retired/*.cxx

find . \( -name '*.h' -or -name '*.cpp' -or -name '*.tpp' -or -name '*.cxx' \) -exec ../bin/redoSrcCopyrightHeaders.filter.sh {} \;

