import 'package:etherwallet/components/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletReceivePage extends StatelessWidget {
  const WalletReceivePage({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleString: 'address',
      ),
      body:       GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 25.0),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: address));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Copied!'),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(30.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Color(0xfff1f3f6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            address,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          width: 210.0,
                        ),
                        SizedBox(height: 5.0),
                      ],
                    ),
                    Container(
                      height: 45.0,
                      width: 45.0,
                      // decoration: const BoxDecoration(
                      //   shape: BoxShape.circle,
                      //   color: Color(0xffffac30),
                      // ),
                      child: const Icon(
                        Icons.copy,
                        size: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            QrImage(
              data: address,
              version: QrVersions.auto,
              size: 250.0,
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
