import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:walletsolana/Page/SendSol/SendToAnother.dart';
import 'package:walletsolana/Setting/Config.dart';

import '../APICall.dart';
import '../Widget.dart';

class HomePage extends StatefulWidget {
  final String walletAddress;

  const HomePage({Key? key, required this.walletAddress}) : super(key: key);

  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double balance = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _update());
  }

  void _update() async {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                      )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "eWalle",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'ubuntu',
                        fontSize: 25,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Account overview",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'avenir'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFFF1F3F6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: getBalanceOfWallet(widget.walletAddress),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              "$balance Sol",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            );
                          }
                          if (snapshot.hasData) {
                            balance = snapshot.data;
                            return Text(
                              "${snapshot.data} Sol",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            );
                          }
                          return Container();
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Current Balance",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: onAirdropTap,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFac30)),
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Send",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir'),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 30,
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onNewSendTap,
                    child: Container(
                      height: 70,
                      width: 70,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFAC30)),
                      child: Icon(
                        Icons.add,
                        size: 40,
                      ),
                    ),
                  ),
                  avatarWidget(img: "avatar1", name: "Mason"),
                  avatarWidget(img: "avatar2", name: "Victor"),
                  avatarWidget(img: "avatar3", name: "Kevin"),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Services',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'avenir'),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Icon(Icons.dialpad),
                )
              ],
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 0.7,
              children: [
                serviceWidget(img: "sendMoney", name: "Send\nMoney"),
                serviceWidget(img: "receiveMoney", name: "Receive\nMoney"),
                serviceWidget(img: "phone", name: "Mobile\nRecharge"),
                serviceWidget(img: "electricity", name: "Electricity\nBill"),
                serviceWidget(img: "tag", name: "Cashback\nOffer"),
                serviceWidget(img: "movie", name: "Movie\nTicket"),
                serviceWidget(img: "flight", name: "Flight\nTicket"),
                serviceWidget(img: "more", name: "More\n"),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Future<double> getBalanceOfWallet(String _walletAddress) async {
    APICall apiCall = APICall();
    var balance = await apiCall.getBalance(_walletAddress);
    return balance;
  }

  void onAirdropTap() {
    print("On tap");
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return modalBottomSheet();
        });
  }

  void onNewSendTap() {
    print("On tap");
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return modalBottomSheetForSend();
        });
  }

  Container modalBottomSheetForSend() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          rowForSend("Between your wallets", "transfer"),
          rowForSend("To another Wallet", "coin"),
          rowForSend("Scan QR Code", "scan-qr"),
        ],
      ),
    );
  }

  Container rowForSend(String title, String icon) {
    return Container(
      padding: EdgeInsets.all(19),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      child: GestureDetector(
        onTap: () {
          if (icon == "coin") {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SendToAnother(wallet: widget.walletAddress)));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage('assets/images/$icon.png'),
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'ubuntu',
                  fontWeight: FontWeight.w400),
            ))
          ],
        ),
      ),
    );
  }

  Container modalBottomSheet() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Deposit SOL",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Image(image: AssetImage('assets/images/QRCode.png')),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0xFFF1F3F6),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Wallet 1 (${widget.walletAddress.substring(0, 6)}...${widget.walletAddress.substring(38)})",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.walletAddress));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color(0xFF32C7FF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Copy",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'ubuntu'),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              getFaucet();
            },
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
                        "Faucet on ${Config().cluster}",
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
        ],
      ),
    );
  }

  Future<void> getFaucet() async {
    APICall apiCall = APICall();
    await apiCall.requestAirdrop(widget.walletAddress, 1);
    Navigator.pop(context);
    setState(() {});
  }
// Future<void> getBalance() async{
//   APICall apiCall = APICall();
//   balance = await apiCall.getBalance(widget.walletAddress);
// }
}
