#!/bin/bash

echo "Running build script..."
fvm flutter pub upgrade && \
fvm flutter pub get && \
fvm dart run build_runner build --delete-conflicting-outputs && \
fvm flutter gen-l10n