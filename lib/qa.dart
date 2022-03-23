import 'package:flutter/material.dart';
import 'package:mini_qna/auth_service.dart';
import 'package:mini_qna/main.dart';
import 'package:mini_qna/qnafirst.dart';
import 'package:mini_qna/qnasecond.dart';
import 'package:mini_qna/qnathird.dart';
import 'package:provider/provider.dart';

class Qna extends StatefulWidget {
  const Qna({Key? key}) : super(key: key);

  @override
  _QnaState createState() => _QnaState();
}

class _QnaState extends State<Qna> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
        children: [
          QnaFirstPage(),
          QnaSecondPage(),
          QnaThirdPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // 현재 보여주는 탭
        onTap: (newIndex) {
          print("selected newIndex : $newIndex");
          // 다른 페이지로 이동
          setState(() {
            currentIndex = newIndex;
          });
        },
        //selectedItemColor: starbucksPrimaryColor, // 선택된 아이콘 색상
        unselectedItemColor: Colors.white, // 선택되지 않은 아이콘 색상
        showSelectedLabels: false, // 선택된 항목 label 숨기기
        showUnselectedLabels: false, // 선택되지 않은 항목 label 숨기기
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
        backgroundColor: Colors.pink,
        items: [
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.label_important_outline_rounded),
                  Text(
                    "답변하기",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.question_answer),
                  Text("질문하기",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ],
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.wallet_giftcard),
                  Text("마이페이지",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ],
              ),
              label: ""),
        ],
      ),
    );
  }
}
