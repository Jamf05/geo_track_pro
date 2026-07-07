#!/bin/bash

set -e

if which lcov; then
    echo "✅ Package 'lcov' is present."
else
    echo "❌ Package 'lcov' is not present."
    exit 0
fi

fvm flutter test --coverage

if [ -s coverage/lcov.info ]; then
    echo "✅ Coverage report generated successfully."
    lcov \
        --ignore-errors unused \
        --remove coverage/lcov.info \
        'lib/src/generated/*' \
        -o coverage/lcov.info
    genhtml coverage/lcov.info -o coverage/html
    open coverage/html/index.html 
else
    echo "❌ Coverage report generation failed. The coverage/lcov.info file is empty."
    exit 1
fi
