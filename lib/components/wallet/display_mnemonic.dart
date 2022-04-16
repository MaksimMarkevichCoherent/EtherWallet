import 'package:etherwallet/components/copyButton/copy_button.dart';
import 'package:etherwallet/components/welcomeButton/welcome_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DisplayMnemonic extends HookWidget {
  const DisplayMnemonic({Key? key, required this.mnemonic, this.onNext}) : super(key: key);

  final String mnemonic;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        margin: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Text(
                'Get a piece of papper, write down your seed phrase and keep it safe. This is the only way to recover your funds.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: mnemonic));

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Copied'),
                  ));
                },
                child: Container(
                  height: 400,
                  margin: const EdgeInsets.all(25),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8FAFB),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    mnemonic,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  WalletButton(
                    width: 300,
                    onTap: onNext!,
                    label: 'Next',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
