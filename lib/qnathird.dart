import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_qna/main.dart';
import 'package:mini_qna/qna_service.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

class QnaThirdPage extends StatelessWidget {
  const QnaThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Page",
            style: TextStyle(
              color: Colors.pink[200],
              fontWeight: FontWeight.bold,
              fontFamily: 'Jua',
            ),
          ),
          backgroundColor: Colors.amber[50],
          actions: [
            TextButton(
              child: Text("logout",
                  style: TextStyle(
                    color: Colors.pink[200],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jua',
                  )),
              onPressed: () {
                //로그아웃
                context
                    .read<AuthService>()
                    .signOut(); //여긴 consumer로 감싸지않아 1회성 접근하는 context.read
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ]),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/team13.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "DAIQA",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Mini PJT 13조",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Jua',
              ),
            ),
            SizedBox(
              height: 20,
              width: 150,
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: Colors.purple[50],
              child: ListTile(
                leading: Icon(Icons.currency_bitcoin),
                title: Text('8'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: Colors.purple[50],
              child: ListTile(
                leading: Icon(Icons.mail),
                title: Text('changNo1@sparta.com'),
              ),
            )
          ],
        ),
      ),
      // body: Container(
      //   color: Colors.amber[50],
      //   child: Column(
      //     children: [
      //       SizedBox(height: 50),
      //       Padding(
      //         padding: const EdgeInsets.all(40.0),
      //         child: ListTile(
      //           leading: IconButton(
      //             icon: Icon(Icons.person_add),
      //             iconSize: 40,
      //             onPressed: () {},
      //           ),
      //           title: Row(
      //             children: [
      //               Text(
      //                 "ID",
      //                 style: TextStyle(fontWeight: FontWeight.bold),
      //               ),
      //               SizedBox(width: 5),
      //               Text(":"),
      //               SizedBox(width: 10),
      //               Text(
      //                 "스파르타 팀 13",
      //                 style: TextStyle(fontWeight: FontWeight.bold),
      //               )
      //             ],
      //           ),
      //           subtitle: Row(
      //             children: [
      //               Text(
      //                 'MY COIN',
      //                 style: TextStyle(fontWeight: FontWeight.bold),
      //               ),
      //               SizedBox(width: 40),
      //               Text('350')
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
