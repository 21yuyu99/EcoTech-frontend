import 'package:frontend/utils/user_info.dart';
import 'package:http/http.dart' as http;

Future<String> settingCheck() async{
  final user = await get_user(true,false);
  var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/user/check');
  var response = await http.post(url,body:{
    "user_id" : user[0]
  });
  return response.body;
}