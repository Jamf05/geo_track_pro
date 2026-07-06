#!/bin/bash

set -e

fvm flutter pub upgrade
fvm flutter pub get

if fvm dart pub deps | grep 'envied'; then
    echo "✅ Dependency 'envied' is present."
    fvm dart pub add envied dev:envied_generator dev:build_runner
else
    echo "❌ Dependency 'envied' is not present."
fi

if fvm dart pub deps | grep 'build_runner'; then
    echo "✅ Dependency 'build_runner' is present."
    fvm dart run build_runner build --delete-conflicting-outputs
else
    echo "❌ Dependency 'build_runner' is not present."
fi

if ls | grep 'l10n.yaml'; then
    echo "✅ File 'l10n.yaml' is present."
    fvm flutter gen-l10n
else
    echo "❌ File 'l10n.yaml' is not present."
fi