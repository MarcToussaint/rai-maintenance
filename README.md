# RAI maintenance

This repo has [RAI](https://github.com/MarcToussaint/rai) as a
submodule and provides tools for maintenance:

* Testing the whole install/compile pipeline from fresh
* Testing in docker
* Maintenance of code formatting and copyright headers

## local install and test

```
git clone git@github.com:MarcToussaint/rai-maintenance.git
cd rai-maintenance

# if you don't have a github account: (switch submodules to public url)
git config --file=.gitmodules submodule.rai.url https://github.com/MarcToussaint/rai.git
git config --file=.gitmodules submodule.rai-robotModels.url https://github.com/MarcToussaint/rai-robotModels.git

git submodule init
git submodule update

make -j1 initUbuntuPackages  # calls sudo apt-get install; you can always interrupt
make -j4                     # builds libs and tests
make runTests
make -C rai bin
```

With the local [blob/master/config.mk] you can control external dependencies.


## docker


In the [blob/master/docker/] path there are scripts to compile RAI and run tests in a docker. To test the whole pipeline, run
'''
docker/build-docker.sh
docker/run-docker.sh
'''

The [blob/master/docker/Dockerfile] is pretty generic.

The [blob/master/docker/run-docker.sh] authorizes X-display, mounts also .ssh within the docker to authorize you with github, and then executes run-in-docker.sh.

The [blob/master/docker/run-in-docker.sh] is similar to the above 'compile and test'.




