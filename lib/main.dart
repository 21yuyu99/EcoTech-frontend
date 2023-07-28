import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/mainPage.dart';
import 'package:frontend/screen/record/check_page.dart';
import 'package:frontend/utils/new_member_check.dart';
import 'package:frontend/utils/settings_check.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'firebase_options.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 처리.. ${message.notification!.body!}");
}

void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
      'high_importance_channel', 'high_importance_notification',
      importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeNotification();
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'MainFont',
          scaffoldBackgroundColor: Colors.white,
      ),
      builder: (context, child) {
        return MediaQuery(
          child: child as Widget,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
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
  var messageString = "";
  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $token");
  }
  @override
  void initState(){
    getMyDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );
        setState(() {
          messageString = message.notification!.body!;
          print("Foreground 메시지 수신: $messageString");
        });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data['click_action'] == 'FLUTTER_NOTIFICATION_CLICK') {
        final user_info = await settingCheck();
        final Map parsed = json.decode(user_info);
        // Here, we navigate to another screen. You can push to named routes, but here is an example of how to push a new screen onto the stack.
        if(parsed['status'] == 200) {
          print(parsed);
          if (parsed['save_check'] == 1) {
            Fluttertoast.showToast(
              msg: "오늘 하루 체크를 이미 했어요!",
              gravity: ToastGravity.BOTTOM,
              fontSize: 16.0,
              textColor: Colors.black,
              backgroundColor: Colors.white,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }
          else{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckPage(carhabit: parsed["car_habit"])),
            );
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthApi.instance.hasToken(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            if (snapshot.data == true) {
              final google_user = FirebaseAuth.instance.currentUser;
              if(google_user != null){
                newMemberCheck(context);
                return Text("");
              }
              try {
                FutureBuilder(
                  future : UserApi.instance.accessTokenInfo(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    AccessTokenInfo tokenInfo = snapshot as AccessTokenInfo;
                    print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
                    User user =  UserApi.instance.me() as User;
                    print('카카오톡 닉네임 : ${user.kakaoAccount?.profile?.nickname}');
                    newMemberCheck(context);
                    return Text("");
                  },
                );
                newMemberCheck(context);
                return Text("");
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
                newMemberCheck(context);
                return Text("");
              } else {
                print('발급된 토큰 없음');
                return LoginPage();
              }
            }
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          })
      );
  }
}