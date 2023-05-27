
import 'dart:io';

late bool isConnected;

Future<bool> CheckConnection() async{
  isConnected = false;
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnected = true;
      return isConnected;
    }
  } on SocketException catch (_) {
    //print('not connected');
    return isConnected;
  }
  return isConnected;
}