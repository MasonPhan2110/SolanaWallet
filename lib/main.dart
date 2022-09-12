import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:walletsolana/DatabaseHelper.dart';
import 'package:walletsolana/Page/CreateWallet.dart';
import 'package:walletsolana/Page/HomePage.dart';
import 'package:walletsolana/Page/ImportWalletSeedPhrase.dart';
import 'package:walletsolana/Page/Welcome.dart';
import 'package:walletsolana/Page/Welcomeback.dart';
import 'Model/User.dart';
import 'Page/HomeWithSidebar.dart';
import 'package:location/location.dart';

void main() {
  runApp(SolanaWallet());
}

class SolanaWallet extends StatefulWidget {
  const SolanaWallet({Key? key}) : super(key: key);

  @override
  State<SolanaWallet> createState() => _SolanaWalletState();
}

class _SolanaWalletState extends State<SolanaWallet> {
  int userCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsersCount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userCount == 0 ? Welcome() : Welcomeback(),
      routes: {'/homePage': (context) => HomeWithSideBar()},
    );
  }

  Future<void> getUsersCount() async {
    DatabaseHelper _dbHelper = DatabaseHelper();
    List<User> listUser = await _dbHelper.getUser();
    print(listUser[0]);
    userCount = listUser.length;
    setState(() {});
  }
}
