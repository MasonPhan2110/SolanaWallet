import 'package:flutter/material.dart';
import 'package:walletsolana/Widget.dart';

class ImportWallet extends StatelessWidget {
  const ImportWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: importWallet(),
    );
  }
}

class importWallet extends StatefulWidget {
  const importWallet({Key? key}) : super(key: key);

  @override
  State<importWallet> createState() => _importWallet();
}

class _importWallet extends State<importWallet> {
  int size = 12;

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
                  ))
              // secretPhrase(Index: 1)
            ])));
  }

  Widget secretRecoveryPhrase(int length) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < length; i++) {
      if (i % 3 == 0) {
        list.add(rowSecretPhrase(start: i + 1));
      }
    }
    return new Column(children: list);
  }
}
