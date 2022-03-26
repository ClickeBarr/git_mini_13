import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QnaService extends ChangeNotifier {
  final qnaCollection = FirebaseFirestore.instance.collection('qna');

  QnaService() {
    print('QNASERVICE START');
    readAll();
    notifyListeners();
  }

  Future<QuerySnapshot> read(String uid) async {
    return qnaCollection.where('uid', isEqualTo: uid).get();
  } // 내가 작성한 question만 가져오도록 만듬

  List<String> questionList = [];

  Future<QuerySnapshot> readAll() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await qnaCollection.get();
    querySnapshot.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> e) {
      Map<String, dynamic> json = e.data();
      questionList.add(json['question']);
    });
    print(questionList);
    return qnaCollection.get();
  }

  void create(String question, String uid) async {
    await qnaCollection.add({
      'question': question,
      'uid': uid, // 유저 식별자
      // 'isDone': false, // 완료 여부
    });
    notifyListeners(); // 화면 갱신
  }

  void update(String docID, bool isDone) async {
    // bucket isDone 업데이트
    await qnaCollection.doc(docID).update({'isDone': isDone});
    notifyListeners(); // 화면 갱신
  }

  void delete(String docId) async {
    // bucket 삭제
    await qnaCollection.doc(docId).delete();
    notifyListeners(); // 화면 갱신
  }
}
