
import 'dart:io';

Future<bool> CheckConnection() async{
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //print('connected');
      return true;
    }
  } on SocketException catch (_) {
    //print('not connected');
    return false;
  }
  return false;
}