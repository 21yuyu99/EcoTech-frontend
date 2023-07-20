import 'package:firebase_auth/firebase_auth.dart' as google;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/mypage/setting.dart';
import 'package:frontend/utils/which_login.dart';
import 'package:frontend/widget/bottom_bar.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();

}


class _MyPageState extends State<MyPage> {
  String? nickname;

  @override
  void initState() {
    super.initState();
    fetchNickname();
  }

  void fetchNickname() async {
    String which = await which_login();
    if(which == "google") {
      try {
        final FirebaseAuth auth = FirebaseAuth.instance;
        final google.User? user = auth.currentUser;
          setState(() {
            nickname = user?.displayName;
        });
      }
      catch (error) {
        print("구글 닉네임 불러오기 오류");
      }
    }
    else if(which == "kakao"){
      try {
        final kakao.User kakaoUser = await kakao.UserApi.instance.me();
        setState(() {
          nickname = kakaoUser.kakaoAccount?.profile?.nickname;
        });
      } catch (e) {
        print('카카오 사용자 정보 요청 실패: $e');
      }
    }
    else{
      print("닉네임 불러오기 에러");
    }
  }
  void logout() async {
    String which = await which_login();
    if(which == "google"){
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
    else if(which == "kakao"){
        try{
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
    else{
      print("로그아웃 실패");
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
              const SizedBox(width: 25,),
              Text("${nickname}님"?? "loading", style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500)),
              const SizedBox(width: 15,),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      logout();
                    },
                    child: const Text(
                      "로그아웃",
                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFF1A7),
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text("LV.1", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),),
              const SizedBox(height: 30,),
              Image.asset('assets/img/lv1Icon.png', height: 230, width: 230,),
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