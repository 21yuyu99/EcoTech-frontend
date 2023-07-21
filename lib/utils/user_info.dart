import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/utils/which_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:firebase_auth/firebase_auth.dart' as google;

Future<List<String>> get_user(bool wantUid,bool wantNickName) async {
  String which = await which_login();
  var user_id = "",nickname = "";
  if (which == "google") {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final google.User? user = auth.currentUser;
      if(wantUid){
        user_id = user!.uid;
      }
      if(wantNickName){
        nickname = user!.displayName!;
      }
    }
    catch (error) {
      print("구글 정보 보내기 오류");
    }
  }
  else if (which == "kakao") {
    try {
      final kakao.User user = await kakao.UserApi.instance.me();
      if(wantUid){
        user_id = user.id.toString();
      }
      if(wantNickName){
        nickname = user.properties!['nickname']!;
      }
    } catch (e) {
      print('카카오 사용자 정보 보내기 실패: $e');
    }
  }
  else {
    print("정보 가져오기 오류");
  }
  return [user_id,nickname];
}

