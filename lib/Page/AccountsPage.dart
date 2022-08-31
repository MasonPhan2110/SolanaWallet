import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: accountsPage(),
    );
  }
}
class accountsPage extends StatefulWidget {
  const accountsPage({Key? key}) : super(key: key);

  @override
  State<accountsPage> createState() => _accountsPage();
}

class _accountsPage extends State<accountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

