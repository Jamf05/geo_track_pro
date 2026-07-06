#!/bin/bash

set -e

if which lcov; then
    echo "✅ Package 'lcov' is present."
else
    echo "❌ Package 'lcov' is not present."
    exit 0
fi

fvm flutter test --coverage
lcov --ignore-errors unused --remove coverage/lcov.info 'lib/src/generated/*' -o coverage/lcov.info
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.htmlComo puedo 