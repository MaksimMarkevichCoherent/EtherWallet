import 'package:etherwallet/components/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'context/wallet/wallet_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleString: 'Transaction details',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: WebView(
            initialUrl: 'https://ropsten.etherscan.io/address/$address',
          ),
        ),
      ),
    );
  }
}
