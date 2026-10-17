import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    final List<ConnectivityResult> result = await connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  static void checkConnectivity(GlobalKey<ScaffoldMessengerState> globalKey) {
    bool firstTime = true;
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (!firstTime) {
        final bool isNotConnected =
            !result.contains(ConnectivityResult.wifi) && !result.contains(ConnectivityResult.mobile);

        if (!isNotConnected) {
          globalKey.currentState?.hideCurrentSnackBar();
        }

        globalKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: isNotConnected ? Colors.red : Colors.green,
            duration: Duration(seconds: isNotConnected ? 6000 : 3),
            content: Text(isNotConnected ? 'no_connection' : 'connected'),
          ),
        );
      }

      firstTime = false;
    });
  }
}
