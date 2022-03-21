import 'package:etherwallet/resources/icons/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/welcomeButton/welcome_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double sideImageWidth = MediaQuery.of(context).size.width * 0.3;
    final double sideContentWidth = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            height: screenHeight,
            width: sideImageWidth,
            child: SvgPicture.asset(
              IconsSVG.sideImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: sideContentWidth,
            padding: const EdgeInsets.symmetric(
              vertical: 60.0,
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70.0,
                        width: 70.0,
                        child: SvgPicture.asset(
                          IconsSVG.logo,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text(
                        'EWallet',
                        style: TextStyle(
                          fontSize: 50.0,
                          fontFamily: 'ubuntu',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Open An Account For \nDigital E-Wallet Solutions. \nInstant Payouts.\n\nJoin For Free',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                WalletButton(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/create', (route) => false);
                  },
                  label: 'Sign Up',
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/import');
                    },
                    child: const Text(
                      'Recover your account',
                      style: TextStyle(
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
