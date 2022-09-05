import 'package:flutter/material.dart';
import 'package:walletsolana/Page/ImportAccounts.dart';
import 'package:walletsolana/Widget.dart';

class ImportWallet extends StatefulWidget {
  const ImportWallet({Key? key}) : super(key: key);

  @override
  ImportWalletState createState() => ImportWalletState();
}

class ImportWalletState extends State<ImportWallet> {
  int size = 24;
  List<String> secretPhrase = List<String>.filled(24, "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.all(30),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                height: 25,
              ),
              Center(
                child: Text(
                  "Secret Recovery Phrase",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ubuntu'),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "Importing an existing wallet with your 12 or 24-word secret recovery phrase.",
                  style: TextStyle(fontFamily: 'ubuntu', fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              secretRecoveryPhrase((size == 12) ? 24 : 12),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    size = (size == 12) ? 24 : 12;
                    setState(() {});
                  },
                  child: Center(
                    child: Text(
                      "I have a $size-word recovery phrase",
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImportAccount()));
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
                            "Restore Wallet",
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
              // secretPhrase(Index: 1)
            ])));
  }

  Widget secretRecoveryPhrase(int length) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < length; i++) {
      if (i % 3 == 0) {
        list.add(secretPhraseRow(i + 1));
      }
    }
    return new Column(children: list);
  }

  Widget secretPhraseBox(int index) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        // height: 47,
        child: SizedBox(
            width: 95,
            // height: 60,
            child: TextField(
              onChanged: (value) {
                secretPhrase[index - 1] = value;
              },
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                // filled: true,
                  border: InputBorder.none,
                  prefixIcon: Text("$index. "),
                  prefixIconConstraints:
                  BoxConstraints(minWidth: 0, minHeight: 0),
                  isDense: true
                // border: InputBorder.none,
              ),
            )));
  }

  Widget secretPhraseRow(int start) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          secretPhraseBox(start),
          secretPhraseBox(start + 1),
          secretPhraseBox(start + 2)
        ],
      ),
    );
  }
}
