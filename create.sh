#!/bin/bash
docker create \
       --name dockapk8 \
       --network host \
       --mount type=volume,source=dockapk-output,destination=/dockapk-output \
       dockapk:8
