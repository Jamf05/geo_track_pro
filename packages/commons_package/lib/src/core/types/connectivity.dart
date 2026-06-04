import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityFactory extends Connectivity {
  factory ConnectivityFactory() {
    return Connectivity() as ConnectivityFactory;
  }

  bool checkedConnectivity(List<ConnectivityResult> connectivityResult);
}
