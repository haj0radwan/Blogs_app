import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class ConnectionCheck {
  Future<bool> get thereisconnection;
}

class ConnectionCheckImpl implements ConnectionCheck {
  final InternetConnection internetConnection;
  ConnectionCheckImpl(
    this.internetConnection,
  );
  @override
  Future<bool> get thereisconnection async =>
      await internetConnection.hasInternetAccess;
}
