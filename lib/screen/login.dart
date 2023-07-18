import '../utils/colors.dart';
import 'mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  margin: EdgeInsets.only(top:50,left:MediaQuery.of(context).size.width * 0.04,
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
                      SizedBox(height: 60,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02),
                        child: Column(
                          children: [
                            InkWell(onTap:
                                () async {
                              if (await isKakaoTalkInstalled()) {
                                try {
                                  await UserApi.instance.loginWithKakaoTalk();
                                  print('카카오톡으로 로그인 성공');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Home()),
                                  );
                                } catch (error) {
                                  print('카카오톡으로 로그인 실패 $error');

                                  // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                                  try {
                                    await UserApi.instance.loginWithKakaoAccount();
                                    print('카카오계정으로 로그인 성공');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Home()),
                                    );
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Home()),
                                  );
                                }
                                catch (error) {
                                  print('카카오계정으로 로그인 실패 $error');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                }
                              }
                            },
                              child: Image.asset('assets/img/kakao_btn.png'),),
                            SizedBox(height: 35,),
                            Image.asset('assets/img/google_btn.png'),
                          ],
                        ),)
                    ],
                  ),
                ),
              ),
              Positioned(bottom: MediaQuery.of(context).size.height*0.5+100,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Image.asset('assets/img/circle_logo.png',width: 80),
                ),)//
                  ],
                ),
          ),
        );
  }
}