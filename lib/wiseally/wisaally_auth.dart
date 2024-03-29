import 'package:dio/dio.dart';

import 'wisaally_meth.dart';

Dio dio = Dio();

Future<String?> wisaallyAuthorization({
  required String p,
  required String l,
  required String addPath,
}) async {
  final wisaallyIsConnected = await wisaallyIsInternetConnected();
  if (wisaallyIsConnected) {
    try {
      final wisaallyServerAuthKeyResponse = await dio.post(
        addPath,
        data: {"username": l, "password": p},
      );
      if (wisaallyServerAuthKeyResponse.data != null) {
        return wisaallyServerAuthKeyResponse.data['access'];
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  return null;
}
