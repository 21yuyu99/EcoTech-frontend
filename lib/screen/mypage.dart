import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/mypage/setting.dart';
import 'package:frontend/widget/bottom_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

enum AuthMethod {
  google,
  kakao,
}

class AuthService {
  static final AuthService _instance = AuthService._();

  factory AuthService() {
    return _instance;
  }

  AuthService._();
  AuthMethod? method;

  void setMethod(AuthMethod method){
    this.method = method;
  }

  Future<void> logout() async {
    if (method == AuthMethod.google) {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    } else if (method == AuthMethod.kakao) {
      await UserApi.instance.logout();
    }
    method = null;
  }
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIdx: 3,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(LoginPage.getNickname()!, style: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.w500)),
              const SizedBox(width: 15,),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      AuthService().logout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "로그아웃",
                      style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text("LV.1", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),),
              const SizedBox(height: 30,),
              Image.asset('assets/img/lv1Icon.png',),
            ],
          ),
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(20),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
              child: const Text("환경 습관 기본 설정", style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF3F3F3).withOpacity(1), // 버튼 색상을 회색으로 설정
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // 버튼 패딩을 설정하여 크기를 조절
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 버튼의 모서리를 둥글게 설정
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
// class _MyPageState extends State<MyPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomBar(selectedIdx: 3,),
//         body: Column(
//           children: [
//             Center(
//               child: TextButton(
//                   onPressed: () async {
//                     try {
//                       await UserApi.instance.logout();
//                       print('로그아웃 성공, SDK에서 토큰 삭제');
//                     } catch (error) {
//                       print('로그아웃 실패, SDK에서 토큰 삭제 $error');
//                     }
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const LoginPage()),
//                     );
//                   },
//                   child: Text("카카오 로그아웃")),
//             ),
//             Center(
//               child: TextButton(
//                   onPressed: () async {
//                     GoogleSignIn _googleSignIn = GoogleSignIn();
//                     try {
//                       await _googleSignIn.disconnect();
//                       print('로그아웃 성공, SDK에서 토큰 삭제');
//                     } catch (error) {
//                       print('로그아웃 실패, SDK에서 토큰 삭제 $error');
//                     }
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const LoginPage()),
//                     );
//                   },
//                   child: Text("구글 로그아웃")),
//             ),
//           ],
//         )
//     );
//   }
// }
