import 'package:flutter/material.dart';
import 'package:walletsolana/Page/SendSol/EnterTitle.dart';

import '../../Setting/Config.dart';

class InputWalletAddress extends StatefulWidget {
  final String wallet;
  const InputWalletAddress({Key? key, required this.wallet}) : super(key: key);

  InputWalletAddressState createState() => InputWalletAddressState();
}

class InputWalletAddressState extends State<InputWalletAddress> {
  String walletAddress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/arrow.png'),
                          fit: BoxFit.cover),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Enter Wallet Address that you want to transfer to",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'ubuntu'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  walletAddress = value;
                  setState(() {});
                },
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Wallet Address",
                  border: InputBorder.none,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: GestureDetector(
                      onTap: () {
                        if (walletAddress != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => EnterTitle(
                                      walletAddress: walletAddress, walletFrom: widget.wallet)));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 35),
                        decoration: BoxDecoration(
                            color: walletAddress == ""
                                ? Color(0xFFF2F2F2)
                                : Color(0xFFFFac30),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 17,
                            )
                          ],
                        ),
                      )),
                ),
              )
            ])));
  }
}
