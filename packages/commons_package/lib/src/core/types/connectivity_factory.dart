import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityFactory extends Connectivity {
  factory ConnectivityFactory.build() {
    return Connectivity() as ConnectivityFactory;
  }
}
