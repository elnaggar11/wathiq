import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInformation {
  Future<bool> get isConnected;
}

class NetworkInformationImplementation implements NetworkInformation {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInformationImplementation({required this.internetConnectionChecker});
  @override
  Future<bool> get isConnected async =>
      await internetConnectionChecker.hasConnection;
}
