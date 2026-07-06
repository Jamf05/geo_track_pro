#!/bin/bash

if [ ! -d ".fvm/" ]; then
  ln -s ../../.fvm/ ./
else
  echo ".fvm/ already exists"
fi

rsync -avz --delete ../../.agents/ .agents/
rsync -avz --delete ../../.github/ .github/
rsync -avz --delete ../../.vscode/ .vscode/
rsync -avz --delete ../../.fvmrc .fvmrc
rsync -avz --delete ../../.gitignore .gitignore
rsync -avz --delete ../../skills-lock.json skills-lock.json
