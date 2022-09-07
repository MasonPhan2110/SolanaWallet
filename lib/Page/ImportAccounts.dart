import 'package:flutter/material.dart';
import 'package:walletsolana/DatabaseHelper.dart';
import 'package:walletsolana/Model/User.dart';
import 'package:walletsolana/Page/HomeWithSidebar.dart';

class ImportAccount extends StatefulWidget {
  const ImportAccount({Key? key}) : super(key: key);

  @override
  ImportAccountState createState() => ImportAccountState();
}

class ImportAccountState extends State<ImportAccount> {
  bool isEqual = false;
  String pass = "";
  String confirm = "";

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
                  "Create a password",
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
                  "You will use this to unlock your wallet. You can turn on unlock by biometrics in Setting",
                  style: TextStyle(fontFamily: 'ubuntu', fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                onChanged: (value) {
                  pass = value;
                  checkEqual();
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
              SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                onChanged: (value) {
                  confirm = value;
                  checkEqual();
                },
                decoration: InputDecoration(
                  labelText: "Confirm Password",
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
              SizedBox(
                height: 60,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () => isEqual ? addPassword() : null,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: isEqual ? Color(0xFFFFac30) : Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Finish",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                )
                              ]),
                        ),
                      )))
            ])));
  }

  void checkEqual() {
    if (pass == confirm) {
      isEqual = true;
    } else {
      isEqual = false;
    }
    setState(() {});
  }

  Future<void> addPassword() async{
    DatabaseHelper _dbHelper = DatabaseHelper();
    List<User> listUser = await _dbHelper.getUsers();
    User user = User(id: listUser.length, pass: pass);
    await _dbHelper.addUser(user);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (BuildContext context) => HomeWithSideBar()), (route) => false);
  }
}
