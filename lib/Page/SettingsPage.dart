import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 22),
              child: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'avenir'),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            settingTitle("Language"),
            settingTitle("Change Network"),
            settingTitle("Security & Privacy"),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Remove Wallet",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container settingTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 60,
      decoration: BoxDecoration(
          color: Color(0xFFF1F3F6),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: InkWell(
        onTap: () {
          print(title);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 27),
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
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
      ),
    );
  }
}
