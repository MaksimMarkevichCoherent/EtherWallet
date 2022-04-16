import 'package:etherwallet/resources/icons/svg_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Base AppBar implementation with simplified API
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    Key? key,
    this.titleString,
    this.titleWidget,
    this.centerTitle = true,
    this.elevation,
    this.titleColor,
    this.isShowBack = true,
    this.leading,
    this.backgroundColor,
    this.toolbarHeight,
    this.backIconPath,
    this.backIconColor,
    this.onBackPress,
    this.actions,
    this.bottom,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(titleWidget == null || titleString == null,
        '\n\nCannot provide both a titleWidget and a titleString.\nUse only one option\n'),
        super(key: key);

  @override
  Size get preferredSize => Size.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0.0));

  final String? titleString;
  final Widget? titleWidget;
  final bool centerTitle;
  final double? elevation;
  final Color? titleColor;
  final bool isShowBack;
  final Widget? leading;
  final Color? backgroundColor;
  final double? toolbarHeight;
  final String? backIconPath;
  final Color? backIconColor;
  final VoidCallback? onBackPress;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ??
          Text(
            titleString ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
            maxLines: 2,
          ),
      centerTitle: centerTitle,
      toolbarHeight: toolbarHeight,
      elevation: elevation,
      flexibleSpace: const SizedBox(),
      backgroundColor: backgroundColor ?? Colors.white,
      actions: actions,
      automaticallyImplyLeading: isShowBack,
      leading: leading ??
          (isShowBack
              ? CupertinoButton(
            padding: const EdgeInsets.only(left: 0.0, right: 4.0),
            child: SvgPicture.asset(
              backIconPath ?? IconsSVG.arrowLeftIOSStyle,
              color: backIconColor ?? Colors.black,
            ),
            onPressed: onBackPress ?? () => Navigator.pop(context),
          )
              : null),
      bottom: bottom,
    );
  }
}
