import 'package:flutter/material.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({Key? key}) : super(key: key);

  CreateWalletState createState() => CreateWalletState();
}
class CreateWalletState extends State<CreateWallet> {
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
              Center(
                child: Text("Secret Recovery Phrase"),
              )
            ])));
  }
}
