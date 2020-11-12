/*
  Visual Studio Installer:
Visual Studio Community 2019 - 16.7.2
-> Modify
* Desktop development with C++
* Individual components:
Live Share
C++ core features
MSVC v142 - VS 2019 C++ x64/x86 build tools (v14.27)
MSVC v142 - VS 2019 C++ ARM64 build tools (v14.27)
C++ Universal Windows Platform support for v142 build tools (ARM64)
MSVC v142 - VS 2019 C++ ARM build tools (v14.27)
Development Tools plus .NET Core 2.1
ML.NET Model Builder (Preview)
Windows Template Studio

   
  Project -> Manage NuGet packages:
   assimp assimp.redist freeglut freeglut.redist nupengl.core nupengl.core.redist
   perhaps lapack?
  qhull separately. need to compile yourself! for x86! (win32)

  Ipath: C:\Users\User\source\qhull - 2020.1\src; C:\Users\User\source\rai; $(IncludePath)
  Lpath: C:\Users\User\source\repos\ConsoleApplication1\lib; $(LibraryPath)
  Linker Input: qhullstatic.lib
*/

//following the defines in CMakeLists.txt
#define RAI_ROOT_PATH "./" // \"${CMAKE_SOURCE_DIR}/rai\"
//#define RAI_X11
//#define RAI_LAPACK
//#define RAI_EIGEN
#define RAI_PTHREAD
#define RAI_GL
#define RAI_GLFW
#define RAI_QHULL
#define RAI_ASSIMP
#define NO_CYCLE_DETECTION
#define RAI_extern_SWIFT
#define RAI_extern_GJK
#define RAI_extern_Lewiner
#define RAI_extern_ply
#define RAI_extern_ccd

#define RAI_MSVC

#include "../../../rai/Core/util.cpp"
#include "../../../rai/Core/array.cpp"
#include "../../../rai/Core/graph.cpp"
#include "../../../rai/Core/thread.cpp"
#include "../../../rai/Gui/opengl.cpp"
#include "../../../rai/Geo/geo.cpp"
#include "../../../rai/Geo/mesh.cpp"
#include "../../../rai/Geo/mesh_readAssimp.cpp"
#include "../../../rai/Geo/qhull.cpp"

#include "c:/Users/User/Documents/git/rai/test/Gui/opengl/main.cpp"
