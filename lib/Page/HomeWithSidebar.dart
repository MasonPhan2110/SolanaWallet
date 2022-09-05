import 'package:flutter/material.dart';
import 'package:walletsolana/Page/AccountsPage.dart';
import 'package:walletsolana/Page/HelpPage.dart';
import 'package:walletsolana/Page/SettingsPage.dart';
import 'package:walletsolana/Page/TransactionsPage.dart';
import 'HomePage.dart';
import '../main.dart';
import 'ProfilePage.dart';

class HomeWithSideBar extends StatelessWidget {
  const HomeWithSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeWithSideBar(),
      routes: {'/login': (context) => MyApp()},
    );
  }
}

class homeWithSideBar extends StatefulWidget {
  const homeWithSideBar({Key? key}) : super(key: key);

  @override
  State<homeWithSideBar> createState() => _homeWithSideBarState();
}

class _homeWithSideBarState extends State<homeWithSideBar>
    with TickerProviderStateMixin {
  bool sideBarActive = false;
  String page = "Home";
  AnimationController? rotationController;

  @override
  void initState() {
    // TODO: implement initState
    rotationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F3F6),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(60)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Carol Johnson",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Seattle Washington",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  navigatorTitle("Home"),
                  navigatorTitle("Profile"),
                  navigatorTitle("Accounts"),
                  navigatorTitle("Transactions"),
                  navigatorTitle("Settings"),
                  navigatorTitle("Help"),
                ],
              )),
              Container(
                  padding: EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.power_settings_new,
                          size: 30,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  )),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(20),
                child: Text(
                  "Ver 0.0.1",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: (sideBarActive) ? MediaQuery.of(context).size.width * 0.6 : 0,
            top: (sideBarActive) ? MediaQuery.of(context).size.height * 0.2 : 0,
            child: RotationTransition(
              turns: (sideBarActive)
                  ? Tween(begin: -0.05, end: 0.0).animate(rotationController!)
                  : Tween(begin: 0.0, end: -0.05).animate(rotationController!),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: (sideBarActive)
                    ? MediaQuery.of(context).size.height * 0.7
                    : MediaQuery.of(context).size.height,
                width: (sideBarActive)
                    ? MediaQuery.of(context).size.width * 0.8
                    : MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  child: (page == "Home")
                      ? HomePage()
                      : (page == "Profile")
                          ? ProfilePage()
                          : (page == "Accounts")
                              ? AccountsPage()
                              : (page == "Transactions")
                                  ? TransactionsPage()
                                  : (page == "Settings")
                                      ? SettingsPage()
                                      : HelpPage(),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 20,
            child: (sideBarActive)
                ? IconButton(
                    padding: EdgeInsets.all(30),
                    onPressed: closeSideBar,
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  )
                : InkWell(
                    onTap: openSideBar,
                    child: Container(
                      margin: EdgeInsets.all(30),
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/menu.png'))),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  InkWell navigatorTitle(String name) {
    return InkWell(
      onTap: () {
        page = name;
        setState(() {
          print(name);
        });
      },
      child: Row(
        children: [
          if (page == name)
            Container(
              width: 5,
              height: 60,
              color: Color(0xFFFFAC30),
            )
          else
            Container(
              width: 5,
              height: 60,
            ),
          SizedBox(
            width: 10,
            height: 60,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: (page == name) ? FontWeight.w700 : FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  void closeSideBar() {
    sideBarActive = false;
    setState(() {});
  }

  void openSideBar() {
    sideBarActive = true;
    setState(() {});
  }
}
