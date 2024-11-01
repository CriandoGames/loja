import 'package:connectivity_plus/connectivity_plus.dart';

class IsConnection {
  static final IsConnection _instance = IsConnection._internal();

  IsConnection._internal() {
    initializeConnection();
  }

  factory IsConnection() {
    return _instance;
  }

  bool _isConnected = true;
  bool get isConnected => _isConnected;

  void initializeConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _isConnected = connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected = result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi;
    });
  }
}
