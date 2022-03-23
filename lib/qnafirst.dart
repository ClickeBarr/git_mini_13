import 'dart:async';

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
  // StreamController<String> streamController = StreamController<String>();
  @override
  Widget build(BuildContext context) {
    return Consumer<QnaService>(
      builder: (context, qnaService, child) {
        final authService = context.read<AuthService>();
        final user = authService.currentUser()!;
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "데이카 DaiQA",
                style: TextStyle(
                  color: Colors.pink[200],
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                  child: Text("logout",
                      style: TextStyle(
                        color: Colors.pink[200],
                        fontWeight: FontWeight.bold,
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
            body: Column(
              children: [
                SizedBox(height: 35),
                Row(
                  children: [
                    Container(),
                    Spacer(),
                  ],
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('qna')
                          .snapshots(),
                      // qnaService.read(user.uid),
                      builder: (context, snapshot) {
                        final documents = snapshot.data?.docs ?? [];
                        if (documents.isEmpty) {
                          return Center(child: Text('새 질문을 입력해 주세요'));
                        }
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            final doc = documents[index];
                            String qna = doc.get("question");
                            // bool isDone = doc.get("isDone");
                            for (int i = 0; i < documents.length; i++) {}
                            return ListTile(
                              title: Text(qna),
                            );
                          },
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueGrey)),
                    onPressed: () {
                      // qnaService.update(doc.id, isDone);
                    },
                    child: Text("PASS"),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 35),
                //   child: Container(
                //     child: Center(
                //       child: Text('- 질문  -',
                //           style: TextStyle(
                //               fontSize: 20, fontWeight: FontWeight.bold)),
                //     ),
                //     color: Colors.grey[200],
                //     height: 350,
                //     width: double.infinity,
                //   ),
                // ),
                SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.lightBlue)),
                        onPressed: () {
                          qnaService.create(qnaController.text, user.uid);
                        },
                        child: Text(
                          'o',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.lightBlue)),
                          onPressed: () {},
                          child: Text(
                            'x',
                            style: TextStyle(fontSize: 22),
                          )),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
