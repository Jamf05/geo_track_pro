#!/bin/bash

fvm flutter clean && \
rm -rf build && \
rm -rf .dart_tool && \
rm -rf ios/Pods && \
rm -rf ios/Podfile.lock && \
rm -rf ios/.symlinks && \
rm -rf android/.gradle && \
rm -rf android/app/build && \
rm -rf android/build
