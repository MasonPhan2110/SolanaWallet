import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:walletsolana/Page/CreateWallet.dart';
import 'package:walletsolana/Page/HomePage.dart';
import 'package:walletsolana/Page/ImportWallet.dart';
import 'Page/HomeWithSidebar.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: {'/homePage': (context) => HomeWithSideBar()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sideImg.png'),
                    fit: BoxFit.cover),
              )),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getHourMinute(),
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/cloud.png'),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "34° C",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                Text(
                  getDateTime(),
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "eWallet",
                        style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'ubuntu',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Open An Account For \nDigital E-Wallet Solutions.\nInstant Payouts.\n\nJoin For Free",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )),
                InkWell(
                  onTap: openHomePage,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color(0xFFFFac30),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Create Wallet",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 17,
                            )
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have wallet? ",
                      style: TextStyle(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ImportWallet()));
                      },
                      child: Text(
                        "Import Wallet",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF57D9F4),
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getDateTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMM dd, yyyy | EEEE');
    final String formatted = formatter.format(now);
    return formatted;
  }

  String getHourMinute() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('jm');
    final String formatted = formatter.format(now);
    return formatted;
  }

  void openHomePage() {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeWithSideBar()));
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => CreateWallet()));
    // Navigator.of(context,rootNavigator: true).pushNamed('/homePage');
  }

  void getLocations() async {
    // bool serviceEnabled = await location.serviceEnabled();
  }
}
