mkdir build
mkdir build\glfw3
mkdir build\glfw3\windows-debug
mkdir build\glfw3\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DGLFW_BUILD_EXAMPLES=OFF
set FLAGS=%FLAGS% -DGLFW_BUILD_TESTS=OFF
set FLAGS=%FLAGS% -DGLFW_BUILD_DOCS=OFF
set FLAGS=%FLAGS% -DUSE_MSVC_RUNTIME_LIBRARY_DLL=OFF

robocopy glfw-3.3.5 glfwbuild /E /NFL /NDL /NJH /NJS /NP
mkdir glfwbuild\build
cd glfwbuild\build

cmake -G "Visual Studio 16 2019" -A x64 %FLAGS% ..
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..

dir /s glfwbuild
copy glfwbuild\build\src\Debug\glfw3.lib build\glfw3\windows-debug
copy glfwbuild\build\src\Debug\glfw.pdb build\glfw3\windows-debug

copy glfwbuild\build\src\Release\glfw3.lib build\glfw3\windows-release

rmdir /S /Q glfwbuild
