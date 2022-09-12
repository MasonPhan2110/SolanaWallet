import 'package:flutter/material.dart';
import 'package:walletsolana/Page/SendSol/InfoTransaction.dart';

class EnterAmount extends StatefulWidget {
  final String walletAddress;
  final String title;
  const EnterAmount({Key? key, required this.walletAddress, required this.title}) : super(key: key);

  EnterAmountState createState() => EnterAmountState();
}

class EnterAmountState extends State<EnterAmount> {
  double amount = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
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
                "Enter Amount",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'ubuntu'),
              ),
              SizedBox(height: 20,),
              TextField(
                onChanged: (value) {
                  amount = double.parse(value);
                  setState(() {

                  });
                },
                maxLines: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Amount",
                  border: InputBorder.none,
                ),
              ),
              Expanded(child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: GestureDetector(
                    onTap: (){
                      if(amount != 0.0) {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    InfoTransaction(
                                      walletAddress: widget.walletAddress,
                                      title: widget.title,
                                    amount: amount,)));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 35),
                      decoration: BoxDecoration(
                          color: Color(0xFFFFac30),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
