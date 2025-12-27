#!/bin/bash
docker run \
       --net=host \
       --mount type=volume,source=dockapk-output,destination=/dockapk-output \
       dockapk:6
