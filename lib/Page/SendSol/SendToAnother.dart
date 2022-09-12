import 'package:flutter/material.dart';
import 'package:walletsolana/DatabaseHelper.dart';
import 'package:walletsolana/Model/Users.dart';
import 'package:walletsolana/Page/SendSol/InputWalletAddress.dart';
import 'package:walletsolana/Widget.dart';

class SendToAnother extends StatefulWidget {
  const SendToAnother({Key? key}) : super(key: key);

  SendToAnotherState createState() => SendToAnotherState();
}

class SendToAnotherState extends State<SendToAnother> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.only(left: 30, right: 30,
            top: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                onTap: (){Navigator.pop(context);},
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
                  Text("You want to transfer to ...",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'ubuntu'
                  ),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => InputWalletAddress()));
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFF5F5F5)),
                          child: Icon(
                            Icons.add,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(child: Text("New Receiver", style: TextStyle(
                            fontFamily: 'avenir',
                            fontSize: 19,
                            fontWeight: FontWeight.w400
                        ),))
                        ,
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF5F5F5)),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                          hintText: 'Search for receiver',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  Expanded(child: ScrollConfiguration(
                    behavior: NoGlowBehavior(),
                    child: FutureBuilder(
                      future: _dbHelper.getUsers(),
                      builder: (context, AsyncSnapshot<List<Users>> snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                            itemBuilder: ((context, index){
                              return rowForReceiver(snapshot.data?[index].title, "solana");
                            }),
                          );
                        }
                        return Container();
                      },
                    ),
                  ))
            ])));
  }
  Container rowForReceiver(String? title, String icon) {
    return Container(
      padding: EdgeInsets.all(19),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
      child: GestureDetector(
        onTap: () {},
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
            Text(
              title!,
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'ubuntu',
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
