import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/mainPage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  KakaoSdk.init(nativeAppKey: dotenv.env['kakaoKey']);
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '에코테크',
      theme: ThemeData(
          fontFamily: 'MainFont'
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthApi.instance.hasToken(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == true) {
            try {
              FutureBuilder(
                future : UserApi.instance.accessTokenInfo(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                AccessTokenInfo tokenInfo = snapshot as AccessTokenInfo;
                print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
                return Home();
                },
              );
              return Home();
            }
            catch (error) {
              print(error);
              return LoginPage();
            }
            }
            else {
            print('발급된 토큰 없음');
            return LoginPage();
            }
        },
      )
      );
  }
}

