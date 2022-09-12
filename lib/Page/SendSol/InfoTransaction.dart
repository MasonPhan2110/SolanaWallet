import 'package:flutter/material.dart';

class InfoTransaction extends StatefulWidget {
  final String title;
  final String walletAddress;
  final double amount;
  const InfoTransaction({Key? key, required this.title, required this.walletAddress, required this.amount}) : super(key: key);

  InfoTransactionState createState() => InfoTransactionState();
}

class InfoTransactionState extends State<InfoTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
