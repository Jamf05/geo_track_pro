#!/bin/bash

set -e

app=("geo_track_pro")
packages=("auth_package" "commons_package" "geolocation_package" "home_package")

base_path=""
base_path_app="../"
base_path_packages="../../"

current_source=$(grep '^name:' pubspec.yaml | awk '{print $2}')

if [[ " ${app[*]} " == *$current_source* ]]; then
  echo "Current source is an app: $current_source"
  base_path=$base_path_app
elif [[ " ${packages[*]} " == *$current_source* ]]; then
  echo "Current source is a package: $current_source"
  base_path=$base_path_packages
fi

if [ ! -d ".fvm/" ]; then
  ln -s "$base_path/.fvm/" ./
else
  echo ".fvm/ already exists"
fi

rsync -avz --delete "$base_path/.agents/" ".agents/"
rsync -avz --delete "$base_path/.github/" ".github/"
rsync -avz --delete "$base_path/.vscode/" ".vscode/"
rsync -avz "$base_path/.fvmrc" ./.fvmrc
rsync -avz "$base_path/.gitignore" "./.gitignore"
rsync -avz "$base_path/skills-lock.json" "./skills-lock.json"
rsync -avz "$base_path/app/analysis_options.yaml" "./analysis_options.yaml"