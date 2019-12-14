cmake_minimum_required(VERSION 3.4)

project(test_KOMO)

add_compile_options(-O3 -Wall -fPIC -std=c++0x -Wno-terminate)

add_definitions(
  -DRAI_ROOT_PATH=\"${CMAKE_SOURCE_DIR}/rai\"
  -DRAI_X11 -DRAI_LAPACK -DRAI_EIGEN -DRAI_PTHREAD -DRAI_GL
  -DRAI_GLFW -DRAI_QHULL -DRAI_ASSIMP -DNO_CYCLE_DETECTION
  -DRAI_extern_SWIFT -DRAI_extern_GJK -DRAI_extern_Lewiner
  -DRAI_extern_ply -DRAI_extern_ccd
  )

include_directories(
  /usr/include/eigen3
  ../rai/rai
  include
  )

link_directories(
  #  /opt/ros/kinetic/lib
  build
  )

file(GLOB SRC_Core ../rai/rai/Core/*.cpp)
file(GLOB SRC_Algo ../rai/rai/Algo/*.cpp)
file(GLOB SRC_Optim ../rai/rai/Optim/*.cpp)
file(GLOB SRC_Geo ../rai/rai/Geo/*.cpp)
file(GLOB SRC_GeoExtern ../rai/rai/Geo/*/*.c)
file(GLOB SRC_Gui ../rai/rai/Gui/*.cpp)
file(GLOB SRC_Kin ../rai/rai/Kin/*.cpp)
file(GLOB SRC_KinSwift ../rai/rai/Kin/SWIFT/*.cpp)
file(GLOB SRC_KOMO ../rai/rai/KOMO/*.cpp)

add_library(raiKOMO SHARED

  ${SRC_Core}
  ${SRC_Optim}
  ${SRC_Geo}
  ${SRC_GeoExtern}
  ${SRC_Gui}
  ${SRC_Kin}
  ${SRC_KinSwift}
  ${SRC_KOMO}

  ../rai/rai/Algo/spline.cpp
  ../rai/rai/Algo/ann.cpp
  ../rai/rai/Algo/algos.cpp
  
  ../rai/rai/Plot/plot.cpp

  ../rai/rai/Geo/Lewiner/MarchingCubes.cpp

  )

target_link_libraries(raiKOMO
  jsoncpp lapack blas assimp glfw GLEW glut GLU GL X11 qhull pthread rt
  )

add_executable(testKOMO
  ../rai/test/KOMO/tutorial/main.cpp
  )

target_link_libraries(testKOMO
  raiKOMO
  )
