import 'package:etherwallet/resources/icons/svg_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActionDialogItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool showTrailingIcon;

  const ActionDialogItem({
    required this.text,
    required this.onPressed,
    this.showTrailingIcon = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: Color(0xFFFAFAFA),
      child: CupertinoActionSheetAction(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,
                  style: TextStyle(
                    color: Color(0xFF394568),
                    fontSize: 18,
                  )
                  //style: AppTextStyles.r18.copyWith(color: colorScheme.actionSheetItemText),
                  ),
              // SvgPicture.asset(
              //   IconsSVG.icRight,
              //   width: 6.w,
              //   height: 11.h,
              //   color: colorScheme.listItemIcon,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
