import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: settingsPage(),
    );
  }
}
class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  State<settingsPage> createState() => _settingsPage();
}

class _settingsPage extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

