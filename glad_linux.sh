#! /bin/sh

extensions="GL_AMD_debug_output,GL_EXT_texture_compression_s3tc,GL_EXT_texture_filter_anisotropic,GL_EXT_texture_sRGB,GL_EXT_texture_sRGB_decode,GL_KHR_debug,GL_NVX_gpu_memory_info"

mkdir -p build/glad

cd glad-0.1.34
python3 -m glad --profile="core" --api="gl=3.3" --generator="c" --spec="gl" --extensions="$extensions" --reproducible --out-path .

mkdir -p output
mv src/glad.c output/glad.cpp
mv include/glad/glad.h output
mv include/KHR/khrplatform.h output

sed -i "s#<glad/glad.h>#\"glad.h\"#" output/glad.cpp
sed -i "s#<KHR/khrplatform.h>#\"khrplatform.h\"#" output/glad.h

cp output/* ../build/glad

rm -r src include output
