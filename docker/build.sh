#!/usr/bin/env bash
#
# Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

arg_dockerfile=docker/ubuntu-18.04.Dockerfile
arg_imagename=tensorrt-ubuntu
arg_cudaversion=11.3.1
arg_help=0

while [[ "$#" -gt 0 ]]; do case $1 in
  --file) arg_dockerfile="$2"; shift;;
  --tag) arg_imagename="$2"; shift;;
  --cuda) arg_cudaversion="$2"; shift;;
  -h|--help) arg_help=1;;
  *) echo "Unknown parameter passed: $1"; echo "For help type: $0 --help"; exit 1;
esac; shift; done

if [ "$arg_help" -eq "1" ]; then
    echo "Usage: $0 [options]"
    echo " --help or -h         : Print this help menu."
    echo " --file  <dockerfile> : Docker file to use for build."
    echo " --tag   <imagename>  : Image name for the generated container."
    echo " --cuda  <version>    : CUDA version to use."
    exit;
fi

# --platform linux/amd64 flag is for running on M1
docker_args="-f $arg_dockerfile --platform linux/amd64 --build-arg CUDA_VERSION=$arg_cudaversion --build-arg uid=$(id -u) --build-arg gid=$(id -g) --tag=$arg_imagename ."

echo "Building container:"
echo "> docker build $docker_args"
docker build $docker_args

echo "Exporting libei_debug.a"
containerId=$(docker create --platform linux/amd64 tensorrt:latest)
docker cp "$containerId":/workspace/TensorRT/build/out/libei_debug.a docker/
docker rm "$containerId"