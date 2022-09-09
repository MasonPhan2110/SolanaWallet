import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:walletsolana/DatabaseHelper.dart';

import '../Model/User.dart';
import 'HomeWithSidebar.dart';

class Welcomeback extends StatefulWidget {
  const Welcomeback({Key? key}) : super(key: key);

  WelcomebackState createState() => WelcomebackState();
}

class WelcomebackState extends State<Welcomeback> {
  String formattedTime = "";
  String pass = "";
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    formattedTime = getHourMinute();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) => _update());
  }
  void _update() {
    if(!mounted){
      _timer.cancel() ;
      return;
    }
    setState(() {
      formattedTime = getHourMinute();
    });
  }

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
                      formattedTime,
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
                SizedBox(height: 40,),
                Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          TextField(
                            maxLines: 1,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (value) {
                              pass = value;
                              // checkEqual();
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                InkWell(
                  onTap: ()=>continueTap(),
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
                              "Continue",
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
  Future<void> continueTap() async {
    DatabaseHelper _dbHelper = DatabaseHelper();
    List<User> listUsers =  await _dbHelper.getUsers();
    if(listUsers[0].pass == pass) {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) => HomeWithSideBar()));
    } else {
      const snackBar = SnackBar(
        content: Text(
          "Password Invalid",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
