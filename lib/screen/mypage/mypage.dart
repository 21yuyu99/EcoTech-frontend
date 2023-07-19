import 'package:firebase_auth/firebase_auth.dart' as google;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/mypage/setting.dart';
import 'package:frontend/widget/bottom_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

  void nick_name() async {
      try {
        final FirebaseAuth auth = FirebaseAuth.instance;
        final google.User? user = auth.currentUser;
        final uid = user?.uid;
        print(uid);
      } catch(error) {
          try{
            kakao.User user = await kakao.UserApi.instance.me();
            print('사용자 정보 요청 성공'
                '\n회원번호: ${user.id}'
                '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
            );
          } catch (error) {
             print('사용자 정보 요청 실패 $error');
        }
    }
}

class _MyPageState extends State<MyPage> {
  void logout() async {
    if(FirebaseAuth.instance.currentUser!=null){
      try{
        print("구글 로그아웃");
        await FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage()),
            (route) => false,
        );
      } catch(error){
        print("구글 로그아웃 실패");
      }
    }
    else{
      try{
        kakao.User user = await kakao.UserApi.instance.me();
        user.id;
        await kakao.UserApi.instance.logout();
        print('카카오 로그아웃 성공, SDK에서 토큰 삭제');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage()),
            (route) => false,
        );
      } catch (error) {
        print('사용자 정보 요청 실패 $error');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIdx: 3,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text("", style: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.w500)),
              const SizedBox(width: 15,),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      logout();
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