import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_qna/main.dart';
import 'package:mini_qna/qna_service.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

// final firestore = FirebaseFirestore.instance;

class QnaFirstPage extends StatefulWidget {
  const QnaFirstPage({Key? key}) : super(key: key);

  @override
  State<QnaFirstPage> createState() => _QnaFirstPageState();
}

class _QnaFirstPageState extends State<QnaFirstPage> {
  TextEditingController qnaController = TextEditingController();
  int selectedIndex = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(
      () {
        _counter++;
      },
    );
  }

  // StreamController<String> streamController = StreamController<String>();
  @override
  Widget build(BuildContext context) {
    return Consumer<QnaService>(
      builder: (context, qnaService, child) {
        final authService = context.read<AuthService>();
        final user = authService.currentUser()!;

        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('qna').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final documents = snapshot.data?.docs ?? [];
            List<String> questionList = [];
            documents.forEach((e) {
              Map<String, dynamic> json = e.data();
              questionList.add(json['question']);
            });
            // print(questionList);
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "데이카 DaiQA",
                  style: TextStyle(
                    color: Colors.pink[200],
                    fontWeight: FontWeight.bold,
                    fontFamily: "Jua",
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
                ],
              ),
              body: Container(
                color: Colors.amber[50],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 90),
                      Row(
                        children: [
                          Container(),
                          Spacer(),
                        ],
                      ),
                      Expanded(
                        child: documents.isEmpty
                            ? Center(
                                child: Text(
                                  '새 질문을 입력해 주세요',
                                ),
                              )
                            : Center(
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      border: Border.all(color: Colors.purple),
                                    ),
                                    // child: ListView.builder(
                                    //     itemCount: 1,
                                    //     itemBuilder: (context, index) {
                                    // return
                                    // alignment: Alignment.center,
                                    child: Text(
                                      qnaService.questionList[selectedIndex],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Jua",
                                      ),
                                      // textAlign: TextAlign.center,
                                    )
                                    // },
                                    ),
                              ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blueGrey)),
                          onPressed: () {
                            setState(() {
                              selectedIndex = (Random().nextDouble() *
                                      qnaService.questionList.length)
                                  .toInt();
                            });
                            // qnaService.shuffleQuestionList();
                          },
                          child: Text(
                            "PASS",
                            style: TextStyle(
                              fontFamily: "Jua",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonBar(
                            buttonPadding: EdgeInsets.symmetric(horizontal: 50),
                            children: [
                              //OButton
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  minimumSize: Size(80, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side:
                                      BorderSide(color: Colors.blue, width: 3),
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      selectedIndex = (Random().nextDouble() *
                                              qnaService.questionList.length)
                                          .toInt();
                                    },
                                  );
                                  _incrementCounter();
                                  print('$_counter');
                                },
                                child: Text(
                                  'O',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                              // Spacer(),
                              // Xbutton
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.yellow,
                                  minimumSize: Size(80, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(
                                      color: Colors.yellow, width: 3),
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      selectedIndex = (Random().nextDouble() *
                                              qnaService.questionList.length)
                                          .toInt();
                                    },
                                  );
                                  _incrementCounter();
                                  print('$_counter');
                                },
                                child: Text(
                                  'X',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        color: Colors.grey[300],
                        child: Row(
                          children: [
                            Text(
                              "MY COIN",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Jua',
                              ),
                            ),
                            Spacer(),
                            Text(
                              '$_counter',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontFamily: 'Jua',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
