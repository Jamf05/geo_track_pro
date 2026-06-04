import 'package:riverpod/riverpod.dart';

import 'app_localizations.dart';
import 'state.dart';

abstract class Presenter<S extends State> extends Notifier<S> {
  Presenter();
  
  void setUi(AppLocalizations l10n) {}
  void onInit() {}
  void onDispose() {}
}
