import 'package:flutter/material.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/widget/bottom_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIdx: 3,),
        body: Column(
          children: [
            Center(
              child: TextButton(
                  onPressed: () async {
                    try {
                      await UserApi.instance.logout();
                      print('로그아웃 성공, SDK에서 토큰 삭제');
                    } catch (error) {
                      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text("카카오 로그아웃")),
            ),
            Center(
              child: TextButton(
                  onPressed: () async {
                    GoogleSignIn _googleSignIn = GoogleSignIn();
                    try {
                      await _googleSignIn.disconnect();
                      print('로그아웃 성공, SDK에서 토큰 삭제');
                    } catch (error) {
                      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text("구글 로그아웃")),
            ),
          ],
        )
    );
  }
}
