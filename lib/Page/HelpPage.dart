import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: helpPage(),
    );
  }
}

class helpPage extends StatefulWidget {
  const helpPage({Key? key}) : super(key: key);

  @override
  State<helpPage> createState() => _helpPage();
}

class _helpPage extends State<helpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
