import 'package:flutter/material.dart';
import 'package:mini_qna/auth_service.dart';
import 'package:mini_qna/main.dart';
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

class QnaFirstPage extends StatelessWidget {
  const QnaFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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

              /// Tip : AppBar 하단에 TabBar를 만들어 줍니다.
              // bottom: TabBar(
              //   isScrollable: false,
              //   //indicatorColor: starbucksPrimaryColor,
              //   indicatorWeight: 4,
              //   labelColor: Colors.black,
              //   unselectedLabelColor: Colors.grey,
              //   labelStyle: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              //   tabs: [
              //     Tab(text: "대답하기"),
              //     Tab(text: "질문하기"),
              //   ],
              // ),
            ),
            body: Column(
              children: [
                SizedBox(height: 35),
                Row(
                  children: [
                    Container(),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 45),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueGrey)),
                        onPressed: () {},
                        child: Text("PASS"),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Container(
                    child: Center(
                      child: Text('- 질문  -',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    color: Colors.grey[200],
                    height: 350,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.lightBlue)),
                        onPressed: () {},
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
            )));
  }
}

class QnaSecondPage extends StatelessWidget {
  const QnaSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Container(
                  //color: Colors.pink[200],
                  height: 60,
                  child: Center(
                      child: Text("+   새로운 질문하기",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  '내가 한 질문 보기',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            ListTile(
                leading: Icon(Icons.format_list_numbered_rtl),
                title: Text(
                    '주5일 근무하고 월급 400만원이면 [O], \n주4일 근무하고 월급 300만원이면 [X]',
                    style: TextStyle(fontSize: 14))),
            ListTile(
                leading: Icon(Icons.format_list_numbered_rtl),
                title: Text('올해(2022년) 해외 여행을 갈 계획이 있습니까?',
                    style: TextStyle(fontSize: 14))),
            ListTile(
                leading: Icon(Icons.format_list_numbered_rtl),
                title: Text('둘째 출산장려금 5000만원을 지급한다면, \n둘째를 가질 의향은?',
                    style: TextStyle(fontSize: 14))),
          ],
        ));
  }
}

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
              ),
            ),
            backgroundColor: Colors.white),
        body: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.person_add),
                  iconSize: 40,
                  onPressed: () {},
                ),
                title: Row(
                  children: [
                    Text(
                      "ID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(":"),
                    SizedBox(width: 10),
                    Text(
                      "스파르타 팀 13",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      'MYPOINT',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 40),
                    Text('350')
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
