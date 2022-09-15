import 'package:flutter/material.dart';
import 'package:walletsolana/APICall.dart';
import 'package:walletsolana/DatabaseHelper.dart';
import 'package:walletsolana/Model/Users.dart';

class EnterAmount extends StatefulWidget {
  final String walletAddress;
  final String title;
  final String walletFrom;
  const EnterAmount(
      {Key? key, required this.walletAddress, required this.title, required this.walletFrom})
      : super(key: key);

  EnterAmountState createState() => EnterAmountState();
}

class EnterAmountState extends State<EnterAmount> {
  double amount = 0.0;
  DatabaseHelper _dbHelper = DatabaseHelper();
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
                "Enter Amount",
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
                  amount = double.parse(value);
                  setState(() {});
                },
                maxLines: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Amount",
                  border: InputBorder.none,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: GestureDetector(
                      onTap: () {
                        if (amount != 0.0) {
                          onContinueTap();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 35),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFac30),
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
  void onContinueTap() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return modalBottomSheetForInfo();
        });
  }
  Container modalBottomSheetForInfo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/reject.png'),
                      fit: BoxFit.cover),
                )),
          ),
          SizedBox(height: 10,),
          Text("Transfer Confirmation", style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            fontFamily: 'ubuntu'
          ),),
          SizedBox(height: 20,),
          Text("From: ",style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              fontFamily: 'ubuntu'
          ),),
          SizedBox(height:10),
          Text("Wallet 0", style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'ubuntu',
              fontSize: 20
          ),),
          SizedBox(height: 7,),
          Text(widget.walletFrom),
          SizedBox(height: 20,),
          Text("To: ",style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              fontFamily: 'ubuntu'
          ),),
          SizedBox(height:10),
          Text(widget.title, style: TextStyle(
            fontWeight: FontWeight.w800,
            fontFamily: 'ubuntu',
            fontSize: 20
          ),),
          SizedBox(height: 7,),
          Text(widget.walletAddress),
          SizedBox(height: 20,),
          Text("Amount: ",style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              fontFamily: 'ubuntu'
          ),),
          SizedBox(height: 10,),
          Text("$amount SOL",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'ubuntu'
          ),),
          SizedBox(height: 20,),
          Text("Network Fee:",style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    fontFamily: 'ubuntu'
    ),),
          SizedBox(height: 10,),
          Text("0.000005 SOL",style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    fontFamily: 'ubuntu'
    ),),
          Expanded(child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: GestureDetector(
              onTap: onConfirmTap,
              child: Container(
                padding: EdgeInsets.all(20),
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
              ),
            )
          ))
        ],
      ),
    );
  }

  void onConfirmTap() {
    addUserToDataBase();
    transferSol();
  }
  Future<void> addUserToDataBase() async{
    List<Users> listUsers = await _dbHelper.getUsers();

    Users users = Users(id: listUsers.length, wallet: widget.walletAddress, title: widget.title);
    await _dbHelper.addUsers(users);
  }
  Future<void> transferSol() async{
    APICall apiCall = APICall();
    await apiCall.sendTransaction(widget.walletAddress, 1);
  }
}
