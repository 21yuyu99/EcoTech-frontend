import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as google;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/mypage/setting.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/which_login.dart';
import 'package:frontend/widget/bottom_bar.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:http/http.dart' as http;

import '../../utils/user_info.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();

}


class _MyPageState extends State<MyPage> {
  String? nickname;
  String? level;
  bool info_loading = true;
  bool level_loading = true;
  @override
  void initState() {
    super.initState();
    fetchNickname();
    post_level();
  }
  void post_level() async{
    final user = await get_user(true,false);
    var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/user/mypage');
    var response = await http.post(url,body:{
      "user_id" : user[0]
    });
    final Map parsed = json.decode(response.body);
    if(parsed["status"]==200){
      setState((){
        level = parsed["level"].toString();
        level_loading = false;
      });
    }
    else{
      Fluttertoast.showToast(
          msg: "데이터 불러오기 오류",
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          textColor: Colors.black,
          backgroundColor: Colors.white);
    }
  }
  void fetchNickname() async {
    String which = await which_login();
    if(which == "google") {
      try {
        final FirebaseAuth auth = FirebaseAuth.instance;
        final google.User? user = auth.currentUser;
          setState(() {
            nickname = user?.displayName;
            info_loading = false;
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
          info_loading = false;
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
      bottomNavigationBar: BottomBar(selectedIdx: 2,),
      body: info_loading||level_loading?Center(
        child: CircularProgressIndicator(),
      ):Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const SizedBox(width: 25,),
              Text("${nickname}님"?? "loading", style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500)),
              Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      logout();
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.only(
                        top: 5,
                        left :10,
                        right : 10, bottom : 5
                      ),
                      side: BorderSide(width: 1.0, color: AppColor.accentColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Text(
                      "로그아웃",
                      style: TextStyle(fontSize: 15, color: AppColor.accentColor, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 50,),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text("LV.${level}", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),),
              const SizedBox(height: 15,),
              Image.asset('assets/img/level/circle_level_${level}.png', height: 170, width: 170,),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color:Color(0xffFFF4B8),
                  blurRadius:10,
                  offset: Offset(0,5),
                ),
              ],
            ),
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings(first: false,)),
                  );
                },
                child: const Text("환경 습관 기본 설정", style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.w500),),
                style:ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    side: BorderSide(color: AppColor.accentColor,width: 2),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                )
            ),
          )
        ],
      ),
    );
  }
}