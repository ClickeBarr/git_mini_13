import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_qna/qa.dart';
import 'package:mini_qna/qna_service.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

const KPrimaryColor = Color(0xFF6F35A5);
const KPrimaryLightColor = Color(0xFFF1E6FF);

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작 (필수)
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => QnaService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? LoginPage() : Qna(),
    );
  }
}

/// 로그인 페이지
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.currentUser();
        return MaterialApp(
          // appBar: AppBar(title: Text("")),
          debugShowCheckedModeBanner: false,
          title: 'DaiQA',
          theme: ThemeData(
            primaryColor: KPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: Scaffold(
            body: Container(
              height: size.height,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// 현재 유저 로그인 상태

                  Image(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/2.jpeg"),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 400),
                      Center(
                        child: Text(
                          user == null
                              ? "WELCOME TO DAIQA"
                              : "${user.email}님 안녕하세요 👋",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: KPrimaryColor),
                        ),
                      ),

                      SizedBox(height: 25),

                      /// 이메일
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(hintText: "이메일"),
                        ),
                      ),

                      /// 비밀번호
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          controller: passwordController,
                          obscureText: false, // 비밀번호 안보이게
                          decoration: InputDecoration(hintText: "비밀번호"),
                        ),
                      ),
                      SizedBox(height: 40),

                      /// 로그인 버튼
                      Container(
                        width: size.width * 0.7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            color: KPrimaryColor,
                            child: Text("로 그 인",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            onPressed: () {
                              // 로그인
                              authService.signIn(
                                email: emailController.text,
                                password: passwordController.text,
                                onSuccess: () {
                                  // 로그인 성공
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("로그인 성공"),
                                  ));

                                  // HomePage로 이동
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Qna()),
                                  );
                                },
                                onError: (err) {
                                  // 에러 발생
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(err),
                                  ));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 6),

                      /// 회원가입 버튼
                      Container(
                        width: size.width * 0.7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            color: KPrimaryColor,
                            child: Text("회원가입",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            onPressed: () {
                              // 회원가입
                              authService.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                onSuccess: () {
                                  // 회원가입 성공
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("회원가입 성공"),
                                  ));
                                },
                                onError: (err) {
                                  // 에러 발생
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(err),
                                  ));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class AppListPage extends StatelessWidget {
//   const AppListPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Column(
//               children: [
//                 ListTile(
//                   title: Container(
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: [
//                           Text("묻고 답하고",
//                               style: TextStyle(
//                                   color: Colors.pink,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold)),
//                           Text("Onboarding Page",
//                               style: TextStyle(
//                                   color: Colors.pink,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold))
//                         ],
//                       )),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => Qna()),
//                   ),
//                 ),
//                 SizedBox(height: 230),
//                 Text(
//                   "ID:   _______________",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "PW:   ______________",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 SizedBox(height: 30),
//                 // Text(
//                 //   "V 비밀번호 보이기",
//                 //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 105),
//                   child: Row(
//                     children: [
//                       ElevatedButton(
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.blueGrey)),
//                           onPressed: () {},
//                           child: Text("로그인")),
//                       Spacer(),
//                       ElevatedButton(
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.blueGrey)),
//                           onPressed: () {},
//                           child: Text("회원가입")),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Esc extends StatelessWidget {
//   const Esc({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
