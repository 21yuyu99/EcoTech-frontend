import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/mainPage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:http/http.dart' as http;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
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
              final google_user = FirebaseAuth.instance.currentUser;
              if(google_user != null){
                DisplayName = google_user.displayName!;
                print('구글닉네임 : $DisplayName');
                print('UID: ${google_user.uid}');
                print('email: ${google_user.email}');
                return Home();
              }
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
              final google_user = FirebaseAuth.instance.currentUser;
              if(google_user != null){
                print("구글 로그인 확인");
                DisplayName = google_user.displayName!;
                print('구글닉네임 : $DisplayName');
                print('UID: ${google_user.uid}');
                print('email: ${google_user.email}');
                return Home();
              }
              print('발급된 토큰 없음');
              return LoginPage();
            }
        },
      )
      );
  }
}


