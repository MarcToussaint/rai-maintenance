BASE = rai

src_paths =  $(shell find rai/rai -mindepth 1 -maxdepth 1 -type d -printf "%f ")

test_paths = $(shell find rai/test -maxdepth 3 -name 'Makefile' -printf "%h ")

build: $(src_paths:%=makeDepend/%) $(test_paths:%=makePath/%)

initUbuntuPackages: $(src_paths:%=initUbuntuPackages/%)

clean: $(src_paths:%=cleanPath/%) $(test_paths:%=cleanPath/%)$

runTests: $(test_paths:%=makePath/%) $(test_paths:%=runPath/%)

include $(BASE)/build/generic.mk

.NOTPARALLEL:
