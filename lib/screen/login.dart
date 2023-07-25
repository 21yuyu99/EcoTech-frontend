import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/utils/user_info.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'mypage/setting.dart';

String? DisplayName = '';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  void postInfo() async {
    final user =  await get_user(true, false);
    var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/user/usercheck');
    var response = await http.post(url,body:{
      "user_id" : user[0],
    });
    var data = json.decode(response.body);
    if(data["user_id"]!=user[0]){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Settings(first: true,)),
      );
    }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffFFF09E),
                        Colors.white,
                      ],
                    )
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top:90,left:MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.04,
                    // top : MediaQuery.of(context).size.width * 0.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                    children: [
                      SizedBox(height: 45,),
                      Text("서비스 이용을 위해 로그인이 필요해요",style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.w500),),
                      SizedBox(height: 45,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02),
                        child: Column(
                          children: [
                            InkWell(onTap:
                                () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (await isKakaoTalkInstalled()) {
                                  try {
                                  await UserApi.instance.loginWithKakaoTalk();
                                  print('카카오톡으로 로그인 성공');
                                  postInfo();
                                  } catch (error) {
                                  print('카카오톡으로 로그인 실패 $error');

                                  // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                                  try {
                                  await UserApi.instance.loginWithKakaoAccount();
                                  print('카카오계정으로 로그인 성공');
                                  postInfo();
                                  } catch (error) {
                                  print('카카오계정으로 로그인 실패 $error');
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                  }
                                  }
                                  }
                                  else {
                                  try {
                                  await UserApi.instance.loginWithKakaoAccount();
                                  print('카카오계정으로 로그인 성공');
                                  postInfo();
                                  }
                                  catch (error) {
                                  print('카카오계정으로 로그인 실패 $error');
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                  }
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                            },
                              child: Image.asset('assets/img/kakao_btn.png'),),
                            SizedBox(height: 20,),
                            InkWell(onTap:() async {
                                GoogleSignIn googleSignIn = GoogleSignIn();
                                final googleAccount = await googleSignIn.signIn();
                                if (googleAccount != null) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final googleAuth = await googleAccount.authentication;
                                  if (googleAuth.accessToken != null && googleAuth.idToken != null) {
                                    final credential = GoogleAuthProvider.credential(
                                      idToken: googleAuth.idToken,
                                      accessToken: googleAuth.accessToken,
                                    );
                                    try {
                                      await FirebaseAuth.instance.signInWithCredential(credential);
                                      postInfo();
                                    } on FirebaseAuthException catch (e) {
                                      print('error $e');
                                    } catch (e) {
                                      print('error $e');
                                    }
                                  } else
                                    print('error');
                                } else
                                  print('뒤로가기 error');
                                setState(() {
                                  isLoading = false;
                                });
                            },
                              child : Image.asset('assets/img/google_btn.png'),)
                          ],
                        ),)
                    ],
                  ),
                ),
              ),
              Positioned(bottom: MediaQuery.of(context).size.height*0.5+70,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Image.asset('assets/img/circle_logo.png',width: 80),
                ),),
              isLoading?Center(child: CircularProgressIndicator(),):Text(""),
                ]
          )));}
  }