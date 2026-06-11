# Makefile for Flutter project

coverage:
	fvm flutter test --coverage
	lcov --ignore-errors unused --remove coverage/lcov.info 'lib/core/gen/*' 'lib/core/localization/*' 'lib/presentation/design/fundations*' 'lib/presentation/design/tokens*' -o coverage/lcov.info
	genhtml coverage/lcov.info -o coverage/html
.PHONY: coverage

build:
	fvm dart pub add envied dev:envied_generator dev:build_runner && fvm dart run build_runner build --delete-conflicting-outputs && fvm flutter gen-l10n
.PHONY: build

rebuild:
	make clean_generated && fvm flutter clean && rm -rf pubspec.lock && fvm flutter pub get && fvm dart run build_runner build --delete-conflicting-outputs && fvm flutter gen-l10n
.PHONY: rebuild

pub_get:
	fvm flutter clean && fvm flutter pub get
.PHONY: pub_get

clean_generated:
	find . \( -type d \( -name "gen" -o -name "generated" \) -prune -exec rm -rf {} + \) -o \( -type f -name "*.g.dart" -exec rm -f {} + \)
.PHONY: clean_generated