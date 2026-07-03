#!/bin/bash

echo "Running linter..."

fvm dart run dart_code_linter:metrics analyze lib --fatal-style --fatal-warnings --fatal-performance && \
fvm dart run dart_code_linter:metrics check-unnecessary-nullable lib --fatal-found && \
fvm dart run dart_code_linter:metrics check-unused-files lib --fatal-unused && \
fvm dart run dart_code_linter:metrics check-unused-code lib --fatal-unused && \
fvm dart run dart_code_linter:metrics check-unused-l10n lib --fatal-unused