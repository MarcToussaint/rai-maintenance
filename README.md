# RAI maintenance

This repo has [RAI](https://github.com/MarcToussaint/rai) as a
submodule and provides tools for maintenance:

* Testing the whole install/compile pipeline from fresh
* Testing in docker
* Maintenance of code formatting and copyright headers
* Standardized installs of opencv, bullet, physx from source
* A bit documentation of some rai structures

## local install and test

```
git clone git@github.com:MarcToussaint/rai-maintenance.git
cd rai-maintenance

# if you don't have a github account: (switch submodules to public url)
git config --file=.gitmodules submodule.rai.url https://github.com/MarcToussaint/rai.git
git config --file=.gitmodules submodule.rai-robotModels.url https://github.com/MarcToussaint/rai-robotModels.git

git submodule init
git submodule update

make -j1 installUbuntuAll  # calls sudo apt-get install; you can always interrupt
make -j4                     # builds libs and tests
make runTests
make -C rai bin
```

With the local [config.mk](config.mk) you can control external dependencies.


## docker


In the [docker/](docker/) path there are scripts to compile RAI and run tests in a docker. To test the whole pipeline, run
```
cd docker/mini18
./build-docker.sh
./run-docker.sh /root/local/docker/scripts/test-rai.sh
```

Testing rai-python:
```
./run-docker.sh /root/local/docker/scripts/test-rai-python.sh
```

The [Dockerfile](docker/mini18/Dockerfile) is pretty generic.

The [run-docker.sh](docker/mini18/run-docker.sh) authorizes X-display, mounts also .ssh within the docker to authorize you with github, and then executes run-in-docker.sh.

The [run-in-docker.sh](docker/scripts/test-rai.sh) is similar to the above 'compile and test'.




