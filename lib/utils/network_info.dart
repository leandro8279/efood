import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    final List<ConnectivityResult> _result = await connectivity.checkConnectivity();
    return _result != ConnectivityResult.none;
  }

  static void checkConnectivity(GlobalKey<ScaffoldMessengerState> globalKey) {
    bool _firstTime = true;
    Connectivity().onConnectivityChanged.listen((result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : globalKey.currentState!.hideCurrentSnackBar();
        globalKey.currentState!.showSnackBar(
          SnackBar(
            backgroundColor: isNotConnected ? Colors.red : Colors.green,
            duration: Duration(seconds: isNotConnected ? 6000 : 3),
            content: Text(isNotConnected ? 'no_connection' : 'connected'),
          ),
        );
      }

      _firstTime = false;
    });
  }
}
