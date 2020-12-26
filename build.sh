mkdir -p build-d3mini
cmake -Bbuild-d3mini -GNinja -DCMAKE_TOOLCHAIN_FILE="../Tools/cmake/arm-gcc-toolchain.cmake" \
    -DBOARD=Duet3Mini \
    .