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
        body : Center(
            child: TextButton(onPressed: () async {
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
                child: Text("카카오로그인"))
        )
    );
  }
}