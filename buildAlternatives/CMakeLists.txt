cmake_minimum_required(VERSION 3.4)
project(test_KOMO_komo)

add_compile_options(-O3 -Wall -fPIC -std=c++0x)

add_definitions(
  -DRAI_ROOT_PATH=\"${CMAKE_SOURCE_DIR}/rai\"
  -DRAI_X11 -DRAI_LAPACK -DRAI_EIGEN -DRAI_PTHREAD -DRAI_GL
  -DRAI_GLFW -DRAI_QHULL -DRAI_ASSIMP -DNO_CYCLE_DETECTION
)

include_directories(
  /usr/include/eigen3
  ../rai/rai
)

file(GLOB SRC_Kin ../rai/rai/Kin/*.cpp)

add_executable(komo

../rai/test/KOMO/komo/main.cpp

${SRC_Kin}

../rai/rai/Plot/plot.cpp

../rai/rai/KOMO/komo.cpp
../rai/rai/KOMO/pathTools.cpp
../rai/rai/KOMO/objective.cpp

../rai/rai/Algo/MLcourse.cpp
../rai/rai/Algo/ann.cpp
../rai/rai/Algo/algos.cpp
../rai/rai/Algo/spline.cpp

../rai/rai/Core/util.cpp
../rai/rai/Core/thread.cpp
../rai/rai/Core/array.cpp
../rai/rai/Core/graph.cpp

../rai/rai/Geo/qhull.cpp
../rai/rai/Geo/pairCollision.cpp
../rai/rai/Geo/fclInterface.cpp
../rai/rai/Geo/mesh.cpp
../rai/rai/Geo/mesh_readAssimp.cpp
../rai/rai/Geo/geo.cpp

../rai/rai/Gui/viewer.cpp
../rai/rai/Gui/graphview.cpp
../rai/rai/Gui/opengl.cpp

../rai/rai/Optim/lagrangian.cpp
../rai/rai/Optim/KOMO_Problem.cpp
../rai/rai/Optim/newton.cpp
../rai/rai/Optim/constrained.cpp
../rai/rai/Optim/gradient.cpp
../rai/rai/Optim/Graph_Problem.cpp
../rai/rai/Optim/convert.cpp
../rai/rai/Optim/GraphOptim.cpp
../rai/rai/Optim/optimization.cpp

../rai/rai/Geo/GJK/gjk.c
../rai/rai/Geo/ply/ply.c
../rai/rai/Geo/ccd/polytope.c
../rai/rai/Geo/ccd/support.c
../rai/rai/Geo/ccd/ccd.c
../rai/rai/Geo/ccd/mpr.c
../rai/rai/Geo/ccd/vec3.c

../rai/rai/Geo/Lewiner/MarchingCubes.cpp

../rai/rai/Kin/SWIFT/fileio.cpp
../rai/rai/Kin/SWIFT/lut.cpp
../rai/rai/Kin/SWIFT/mesh.cpp
../rai/rai/Kin/SWIFT/mesh_utils.cpp
../rai/rai/Kin/SWIFT/object.cpp
../rai/rai/Kin/SWIFT/pair.cpp
../rai/rai/Kin/SWIFT/pqueue.cpp
../rai/rai/Kin/SWIFT/scene.cpp

)

target_link_libraries(komo jsoncpp lapack blas assimp glfw GLEW glut GLU GL X11 qhull pthread rt)

