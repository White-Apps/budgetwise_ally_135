import 'package:budgetwise_ally_135/wiseally/wisaally_hive.dart';
import 'package:budgetwise_ally_135/wiseally/wisaally_meth.dart';
import 'package:budgetwise_ally_135/wiseally/wisaally_producer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WisaallyWalletPage extends StatefulWidget {
  final String wisaallyUtms;
  final String wisaallyLink;

  const WisaallyWalletPage({
    required this.wisaallyLink,
    required this.wisaallyUtms,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _WisaallyWalletPageState();
  }
}

class _WisaallyWalletPageState extends State<WisaallyWalletPage> {
  late String wisaallyWvlnk;
  late WebViewController wisaallyWbController;

  void _enableWisaallyRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    wisaallyWvlnk = widget.wisaallyLink;
    if (wisaallyWvlnk.contains('(click_id)')) {
      wisaallyWvlnk =
          wisaallyWvlnk.replaceAll('(click_id)', widget.wisaallyUtms);
    }
    wisaallyWbController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (url) async {
            final wisaallyCurrentUrl = url.url ?? '';

            if (wisaallyCurrentUrl.contains('cabinet')) {
              final localObject = await WisaallyProducer().wisaallyLocalGet();
              if (localObject != null) {
                final localWisaalyVar = WisaallyHive(
                  regwisaally: localObject.regwisaally,
                  strtwisaally: localObject.strtwisaally,
                  logwisaally: localObject.logwisaally,
                  cabwisaally: wisaallyCurrentUrl,
                );
                await WisaallyProducer().wisaallyLocalSet(localWisaalyVar);
              }
            }
            final openInBrowser = wisaallyCurrentUrl.contains('.xlsx') ||
                wisaallyCurrentUrl.contains('.pdf') ||
                wisaallyCurrentUrl.contains('app/po-trade-broker') ||
                wisaallyCurrentUrl.contains('openbrowser=1');
            if (openInBrowser) {
              wisaallyBrowse(wisaallyCurrentUrl);
            }
            if (wisaallyCurrentUrl.contains('logout')) {
              final localObject = await WisaallyProducer().wisaallyLocalGet();
              if (localObject != null) {
                final localWisaalyVar = WisaallyHive(
                  regwisaally: localObject.regwisaally,
                  strtwisaally: localObject.strtwisaally,
                  logwisaally: localObject.logwisaally,
                  cabwisaally: '',
                );
                await WisaallyProducer().wisaallyLocalSet(localWisaalyVar);
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(wisaallyWvlnk))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X) AppleWebKit'
          '/605.1.15 (KHTML, like Gecko) Version/17.2 Mobile/15E148 Safari/604.1, webview_aso_ios_3');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 5));
    });
    _enableWisaallyRotation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await wisaallyWbController.canGoBack()) {
          await wisaallyWbController.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          toolbarHeight: 0,
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom,
          ),
          child: WebViewWidget(
            controller: wisaallyWbController,
          ),
        ),
      ),
    );
  }
}
