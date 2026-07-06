#!/bin/bash

set -e

if [ ! -d ".fvm/" ]; then
  ln -s ../../.fvm/ ./
else
  echo ".fvm/ already exists"
fi

rsync -avz --delete ../../.agents/ .agents/
rsync -avz --delete ../../.github/ .github/
rsync -avz --delete ../../.vscode/ .vscode/
rsync -avz ../../.fvmrc ./.fvmrc
rsync -avz ../../.gitignore ./.gitignore
rsync -avz ../../skills-lock.json ./skills-lock.json
