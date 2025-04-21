#!/bin/bash

BUILD_TAG=$(sudo pluginctl build .)
time sudo pluginctl run --name moondream-2-rapid-deploy --resource request.cpu=2,limit.cpu=2,request.memory=5Gi,limit.memory=5Gi "$BUILD_TAG" -- -stream bottom_camera

# time sudo pluginctl run --name moondream-2-rapid-deploy --resource request.cpu=2,limit.cpu=2,request.memory=5Gi,limit.memory=5Gi $(sudo pluginctl build .) -- -stream bottom_camera

# sudo pluginctl build . && time sudo pluginctl run --name moondream-2-rapid-deploy --resource request.cpu=2,limit.cpu=2,request.memory=5Gi,limit.memory=5Gi 10.31.81.1:5000/local/moondream-2-rapid-deploy -- -stream bottom_camera
