cd ../rai

headache -h ../bin/redoSrcCopyrightHeaders.header -c ../bin/redoSrcCopyrightHeaders.conf \
rai/*/*.h rai/*/*.cpp rai/*/*.tpp rai/*/*.cxx \
rai/*/retired/*.h rai/*/retired/*.cpp rai/*/retired/*.cxx \
rai/*/prec/*.h rai/*/prec/*.cpp rai/*/prec/*.cxx \

find . \( -name '*.h' -or -name '*.cpp' -or -name '*.tpp' -or -name '*.cxx' \) -exec ../bin/redoSrcCopyrightHeaders.filter {} \;

