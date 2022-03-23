import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_qna/main.dart';
import 'package:provider/provider.dart';
import 'package:mini_qna/qna_service.dart';

import 'auth_service.dart';

class QnaSecondPage extends StatefulWidget {
  const QnaSecondPage({Key? key}) : super(key: key);

  @override
  State<QnaSecondPage> createState() => _QnaSecondPageState();
}

class _QnaSecondPageState extends State<QnaSecondPage> {
  TextEditingController qnaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer<QnaService>(builder: (context, qnaService, child) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "묻고 답하기(가제)",
              style: TextStyle(
                color: Colors.pink[200],
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(Icons.search_sharp, color: Colors.grey),
                onPressed: () {
                  print("Pay 우측 상단 아이콘 클릭 됨");
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: 40),
                TextField(
                  controller: qnaController,
                  decoration: InputDecoration(
                    hintText: "새로운 질문을 입력해 주세요",
                  ),
                ),
                ElevatedButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    if (qnaController.text.isNotEmpty) {
                      qnaService.create(qnaController.text, user.uid);
                    }
                  },
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // qnaService.create(qnaController.text, user.uid);
                //   },
                //   child: Container(
                //     //color: Colors.pink[200],
                //     height: 60,
                //     child: Center(
                //         child: Text("+   새로운 질문하기",
                //             style: TextStyle(
                //                 fontSize: 20, fontWeight: FontWeight.bold))),
                //   ),
                // ),

                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '내가 한 질문 보기',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                      future: qnaService.read(user.uid),
                      builder: (context, snapshot) {
                        final documents = snapshot.data?.docs ?? [];
                        if (documents.isEmpty) {
                          return Center(child: Text("내 질문을 추가해 주세요"));
                        }
                        return ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              final doc = documents[index];
                              String question = doc.get('question');
                              // bool isDone = doc.get('isDone');
                              return ListTile(
                                title: Text(question),
                              );
                            });
                      }),
                )
                // ListTile(
                //     leading: Icon(Icons.format_list_numbered_rtl),
                //     title: Text(
                //         '주5일 근무하고 월급 400만원이면 [O], \n주4일 근무하고 월급 300만원이면 [X]',
                //         style: TextStyle(fontSize: 14))),
                // ListTile(
                //     leading: Icon(Icons.format_list_numbered_rtl),
                //     title: Text('올해(2022년) 해외 여행을 갈 계획이 있습니까?',
                //         style: TextStyle(fontSize: 14))),
                // ListTile(
                //     leading: Icon(Icons.format_list_numbered_rtl),
                //     title: Text('둘째 출산장려금 5000만원을 지급한다면, \n둘째를 가질 의향은?',
                //         style: TextStyle(fontSize: 14))),
              ],
            ),
          ));
    });
  }
}
