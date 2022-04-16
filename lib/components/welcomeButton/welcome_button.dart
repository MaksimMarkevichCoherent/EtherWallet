import 'package:flutter/material.dart';

class WalletButton extends StatelessWidget {
  const WalletButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.isLoading = false,
    this.width,
    this.height,
  }) : super(key: key);

  final Function() onTap;
  final String label;
  final bool isLoading;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Color(0xffffac30),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: isLoading
                ? <Widget>[
                    Container(
                      height: 15.0,
                      width: 15.0,
                      child: const CircularProgressIndicator(color: Colors.black),
                    ),
                  ]
                : <Widget>[
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 17,
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
