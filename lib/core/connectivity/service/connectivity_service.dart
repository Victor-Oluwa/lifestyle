import 'dart:async';
import 'dart:io';


class ConnectivityService {
  // Connectivity connectivity = Connectivity();

  // bool hasConnection = false;

  // ConnectivityResult? connectionMedium;

  // StreamController<bool> connectionChangeController =
  //     StreamController.broadcast();

  // Stream<bool> get connectionChange => connectionChangeController.stream;

  // ConnectivityService() {
  //   checkInternetConnection();
  // }

  // Future<bool> checkInternetConnection() async {
  //   // bool previousConnection = hasConnection;

  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       hasConnection = true;
  //       connectionChangeController.add(hasConnection);
  //     } else {
  //       hasConnection = false;
  //       connectionChangeController.add(hasConnection);
  //     }
  //   } on SocketException catch (_) {
  //     hasConnection = false;
  //     connectionChangeController.add(hasConnection);
  //   }
  //   connectionChangeController.add(hasConnection);
  //   // if (previousConnection != hasConnection) {
  //   //   connectionChangeController.add(hasConnection);
  //   // }
  //   return hasConnection;
  // }

  Future<bool> checkInternetConnection() async {
    bool hasConnection = true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    return hasConnection;
  }
}
