#!/bin/bash

echo "Running linter..."

fvm dart run dart_code_linter:metrics analyze lib --no-fatal-style --no-fatal-warnings --no-fatal-performance
fvm dart run dart_code_linter:metrics check-unnecessary-nullable lib --fatal-found
fvm dart run dart_code_linter:metrics check-unused-files lib --fatal-unused
fvm dart run dart_code_linter:metrics check-unused-code lib --fatal-unused