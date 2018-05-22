cd ../rai

astyle --options=../bin/reformatSources.conf \
rai/*/*.h rai/*/*.cpp rai/*/*.tpp rai/*/*.cxx \
rai/*/retired/*.h rai/*/retired/*.cpp rai/*/retired/*.cxx
