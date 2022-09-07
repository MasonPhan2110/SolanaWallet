import 'dart:async';

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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  int userCount = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userCount == 0 ? Welcome() : Welcomeback(),
      routes: {'/homePage': (context) => HomeWithSideBar()},
    );
  }
  Future<void> getUsersCount() async{
    DatabaseHelper _dbHelper = DatabaseHelper();
    List<User> listUser = await _dbHelper.getUsers();
    userCount =  listUser.length;
  }
}
