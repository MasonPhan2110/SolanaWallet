import 'package:flutter/material.dart';

class serviceWidget extends StatelessWidget {
  final String img;
  final String name;

  serviceWidget({Key? key, required this.img, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFFF1F3F6),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/$img.png'))),
              ),
            ),
          ),
        )),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(fontFamily: 'avenir', fontSize: 14),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class avatarWidget extends StatelessWidget {
  final String img;
  final String name;

  const avatarWidget({Key? key, required this.img, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 150,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xFFF1F3F6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/images/$img.png'),
                    fit: BoxFit.contain),
                border: Border.all(color: Colors.black, width: 2)),
          ),
          Text(name,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
              ))
        ],
      ),
    );
  }
}

class secretPhrase extends StatelessWidget {
  final int Index;

  const secretPhrase({Key? key, required this.Index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                  // filled: true,
                  border: InputBorder.none,
                  prefixIcon: Text("$Index. "),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                  isDense: true
                  // border: InputBorder.none,
                  ),
            )));
  }
}

class rowSecretPhrase extends StatelessWidget {
  final int start;

  const rowSecretPhrase({Key? key, required this.start}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          secretPhrase(Index: start),
          secretPhrase(Index: start + 1),
          secretPhrase(Index: start + 2)
        ],
      ),
    );
  }
}
