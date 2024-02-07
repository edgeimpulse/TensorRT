#!/usr/bin/env sh

echo "building ei tensorrt lib"
cd ${TRT_OSSPATH} && \
    mkdir -p build && cd build && \
cmake .. \
-DTRT_LIB_DIR=${TRT_LIBPATH} \
-DTRT_OUT_DIR=/workspace/TensorRT/build/out \
-DCMAKE_TOOLCHAIN_FILE=${TRT_OSSPATH}/cmake/toolchains/cmake_aarch64.toolchain \
-DCUDA_VERSION=11.4 \
-DGPU_ARCHS="53" \
-DCUDNN_LIB=/pdk_files/cudnn/usr/lib/aarch64-linux-gnu/libcudnn.so \
-DCUBLAS_LIB=/usr/lib/aarch64-linux-gnu/libcublas.so \
-DCUBLASLT_LIB=/usr/lib/x86_64-linux-gnu/libcublasLt.so \
-DBUILD_PLUGINS=OFF \
-DBUILD_PARSERS=OFF \
-DBUILD_SAMPLES=OFF \
&& make ei -j$(nproc)

echo "done"