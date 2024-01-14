#! /bin/sh

. ./common_linux.sh

# we made quite a few modifications to the yoga dir so keep this as a reminder for when we update
echo "113b562ccae72f737c3c6016c0129000b6031718b21d662d3032eef87f0264c6 yoga-2.0.1/CMakeLists.txt" | sha256sum -c
standard_cmake yoga yoga-2.0.1 libyoga.a

cp yoga-2.0.1/yoga/*.h build/yoga

rm -r yogabuild
