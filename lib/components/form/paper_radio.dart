import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef OnRadioChanged = void Function(
  dynamic value,
);

class PaperRadio extends StatelessWidget {
  const PaperRadio(
    this.title, {
    this.value,
    this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final dynamic value;
  final String title;
  final dynamic groupValue;
  final OnRadioChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        MyRadioListTile<dynamic>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          leading: title,
        ),
      ],
    );
  }
}

class MyRadioListTile<T> extends StatelessWidget {
  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
    Key? key,
  }) : super(key: key);

  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.orange : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
