import 'connectivity_factory.dart';

abstract class Repository {
  final ConnectivityFactory connectivity;
  const Repository(this.connectivity);
}