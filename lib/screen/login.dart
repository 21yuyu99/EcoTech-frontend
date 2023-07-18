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
          padding: EdgeInsets.only(top: 40),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset('assets/img/yellow_pig.png'),
                  Text("에코테크",style: TextStyle(
                      fontFamily: 'gaegu_bold', letterSpacing: 15.0,
                      fontSize: 40,color: AppColor.primaryColor,fontWeight: FontWeight.w800,height: 1.2),),
                ],
              ),
              Text("서비스 이용을 위해 로그인이 필요해요",style: TextStyle(
                fontSize: 20,fontWeight: FontWeight.w500
              ),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.07),
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
                  SizedBox(height: 45,),
                  Image.asset('assets/img/google_btn.png'),
                ],
              ),)
            ],
          ),
        )
    );
  }
}