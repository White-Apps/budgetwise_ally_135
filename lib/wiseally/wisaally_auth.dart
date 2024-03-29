import 'package:dio/dio.dart';

import 'wisaally_meth.dart';

Future<String?> wisaallyAuthorization({
  required String addPath,
  required String l,
  required String p,
}) async {
  final wisaallyIsConnected = await wisaallyIsInternetConnected();
  if (wisaallyIsConnected) {
    try {
      final wisaallyServerAuthKeyResponse = await Dio().post(
        addPath,
        data: {"username": l, "password": p},
      );
      if (wisaallyServerAuthKeyResponse.data != null) {
        return wisaallyServerAuthKeyResponse.data['access'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  return null;
}
