import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

Future<String> which_login() async{
  if(FirebaseAuth.instance.currentUser!=null){
    return "google";
  }
  else{
    try{
      kakao.User user = await kakao.UserApi.instance.me();
      user.id;
      return "kakao";
    }
    catch (error) {
      print('사용자 정보 요청 실패 $error');
      return "error";
    }
  }
}