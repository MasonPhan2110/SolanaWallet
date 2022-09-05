

import 'package:flutter/material.dart';

class ImportAccount extends StatefulWidget {
  const ImportAccount({Key? key}) : super(key: key);

  @override
  ImportAccountState createState() => ImportAccountState();
}
class ImportAccountState extends State<ImportAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(50),
        child: InkWell(
          onTap: (){Navigator.of(context, rootNavigator: false).pop(context);},
          child: Text("Click"),
        ),
      ),
    );
  }
}
