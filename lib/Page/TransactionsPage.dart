import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: transactionsPage(),
    );
  }
}
class transactionsPage extends StatefulWidget {
  const transactionsPage({Key? key}) : super(key: key);

  @override
  State<transactionsPage> createState() => _transactionsPage();
}

class _transactionsPage extends State<transactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

