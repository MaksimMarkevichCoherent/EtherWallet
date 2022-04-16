import 'package:flutter/material.dart';

import 'import_radio_widget.dart';

class SelectImportTypeWidget extends StatefulWidget {
  const SelectImportTypeWidget({Key? key}) : super(key: key);

  @override
  _SelectImportTypeWidgetState createState() => _SelectImportTypeWidgetState();
}

class _SelectImportTypeWidgetState extends State<SelectImportTypeWidget> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Column(
        children: <Widget>[
          ImportRadioListTile<int>(
            value: 1,
            groupValue: value,
            leading: '',
            title: const Text('Seed'),
            onChanged: (value) => setState(
                    () => value = value!
            ),
          ),
          ImportRadioListTile<int>(
            value: 2,
            groupValue: value,
            leading: '',
            title: Text('Private Key'),
            onChanged: (value) => setState(() => value = value!),
          ),
        ],
      ),
    );
  }
}
