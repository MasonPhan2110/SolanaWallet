import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:walletsolana/APICall.dart';
import 'package:walletsolana/DatabaseHelper.dart';
import 'package:walletsolana/Model/Wallet.dart';
import 'package:walletsolana/Page/ImportAccounts.dart';
import 'package:solana/solana.dart';

class ImportWallet extends StatefulWidget {
  const ImportWallet({Key? key}) : super(key: key);

  @override
  ImportWalletState createState() => ImportWalletState();
}

class ImportWalletState extends State<ImportWallet> {
  int size = 24;
  List<String> secretPhrase = List<String>.filled(24, "");
  DatabaseHelper _dbHelper = DatabaseHelper();

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
                onTap: () => isEnableAddWallet() ? importWalletClick() : null,
                child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: isEnableAddWallet()
                            ? Color(0xFFFFac30)
                            : Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Import Wallet",
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
              ],
              onChanged: (value) {
                secretPhrase[index - 1] = value;
                setState(() {});
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

  Future<void> importWalletClick() async {
    setState(() {});
    showLoaderDialog();
    String seed = "";
    APICall apiCall = APICall();
    bool checkspell = true;
    int sizeSeedPhrase = (size == 12) ? 24 : 12;
    for (var i = 0; i < sizeSeedPhrase; i++) {
      checkspell = await apiCall.checkSpell(secretPhrase[i]);
      if (i != sizeSeedPhrase - 1) {
        seed += secretPhrase[i] + " ";
      } else {
        seed += secretPhrase[i];
      }
    }
    setState(() {});
    Navigator.pop(context);
    if (checkspell) {
      // seed = "mixed copy guard private brass twelve detail viable violin open garment track";
      final signer = await Ed25519HDKeyPair.fromMnemonic(seed);
      print(signer.address);
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      Wallets newWallet = Wallets(
          walletAddress: signer.address, date: formatted, seedphrase: seed);
      _dbHelper.addWallet(newWallet);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ImportAccount()));
    } else {
      const snackBar = SnackBar(
        content: Text(
          "Seed Phrase Invalid",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool isEnableAddWallet() {
    if (size == 12) {
      for (var i = 0; i < 24; i++) {
        if (secretPhrase[i] == "") {
          return false;
        }
      }
    } else {
      for (var i = 0; i < 12; i++) {
        if (secretPhrase[i] == "") {
          return false;
        }
      }
    }
    return true;
  }

  void showLoaderDialog() {
    AlertDialog alert = AlertDialog(
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularProgressIndicator(),
          Container(child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
