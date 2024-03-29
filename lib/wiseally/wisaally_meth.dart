import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
// import 'package:battery_plus/battery_plus.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

Future<bool> wisaallyIsUsingVpn() async {
  var wisaallyConnectivityResult = await (Connectivity().checkConnectivity());

  return wisaallyConnectivityResult == ConnectivityResult.vpn;
}

Future<bool> wisaallyIsSemulator(BuildContext context) async {
  DeviceInfoPlugin wisaallyDeviceInfoPlugin = DeviceInfoPlugin();
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    IosDeviceInfo wisaallyIosDeviceInfo =
        await wisaallyDeviceInfoPlugin.iosInfo;
    return !wisaallyIosDeviceInfo.isPhysicalDevice;
  }
  return false;
}

Future<bool> wisaallyIsInternetConnected() async {
  final FlutterNetworkConnectivity wisaallyFlutterNetworkConnectivity =
      FlutterNetworkConnectivity(
    isContinousLookUp: true,
    lookUpDuration: const Duration(seconds: 5),
  );
  bool wisaallyIsNetworkConnectedOnCall =
      await wisaallyFlutterNetworkConnectivity.isInternetConnectionAvailable();
  return wisaallyIsNetworkConnectedOnCall;
}

Future<int> wisaallyBatteryLevel() async {
  final Battery wisaallyBattery = Battery();
  try {
    int wisaallyBatteryLevel = await wisaallyBattery.batteryLevel;

    return wisaallyBatteryLevel;
  } catch (e) {}
  return 0;
}

Future<bool> wisaallyIsCharging() async {
  final Battery wisaallyBattery = Battery();
  try {
    bool wisaallyIsCharging = false;
    wisaallyBattery.onBatteryStateChanged.listen((BatteryState state) {
      if (state == BatteryState.charging) {
        wisaallyIsCharging = true;
      }
    });
    return wisaallyIsCharging;
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> wisaallyBrowse(String ur) async {
  final url = Uri.parse(ur).normalizePath();
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Sorry, $url no launch');
  }
}

Future<String> wisaallyGetTime() async {
  tzdata.initializeTimeZones();

  tz.TZDateTime moscowTime = tz.TZDateTime.now(tz.getLocation('Europe/Moscow'));
  return DateTime(moscowTime.year, moscowTime.month, moscowTime.day,
          moscowTime.hour, moscowTime.minute)
      .toString();
}

Future<String> wisaallyCountryCode() async {
  await CountryCodes.init();

  final Locale? wisaallyDeviceLocale = CountryCodes.getDeviceLocale();

  if (wisaallyDeviceLocale != null &&
      wisaallyDeviceLocale.countryCode != null) {
    return wisaallyDeviceLocale.countryCode!.toLowerCase();
  }
  return '';
}
