# Edge Impulse TensorRT Wrapper

The `libei_debug.a` file was built from: https://github.com/edgeimpulse/TensorRT/tree/libeitrt - build using:

```
$ sh docker/build.sh --file docker/ubuntu-cross-aarch64.Dockerfile --tag tensorrt --cuda 10.2
```

There are comments in the Dockerfile, which you will need to read to succesfully build it. Specifically, remember to get the [jetpack_files](../README.md#optional---for-jetson-builds-only-download-the-jetpack-sdk).

You can find the library in `/workspace/TensorRT/build/out/libei_debug.a` in the container. It is also automatically copied after a successful build to the /docker folder.

`libei_debug7.a` is a version of the library built with TensorRT 7.x.

