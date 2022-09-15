import 'package:flutter/material.dart';
import 'package:walletsolana/Page/SendSol/EnterAmount.dart';

class EnterTitle extends StatefulWidget {
  final String walletAddress;
  final String walletFrom;
  const EnterTitle({Key? key, required this.walletAddress, required this.walletFrom}) : super(key: key);

  EnterTitleState createState() => EnterTitleState();
}

class EnterTitleState extends State<EnterTitle> {
  String title = "";

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
                "Title of Wallet Address",
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
                  title = value;
                  setState(() {});
                },
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: GestureDetector(
                      onTap: () {
                        if (title != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EnterAmount(
                                        walletAddress: widget.walletAddress,
                                        title: title,
                                        walletFrom: widget.walletFrom,
                                      )));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 35),
                        decoration: BoxDecoration(
                            color: title == ""
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
