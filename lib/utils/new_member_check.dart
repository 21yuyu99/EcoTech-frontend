import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/utils/user_info.dart';
import 'package:http/http.dart' as http;
import '../screen/mainPage.dart';
import '../screen/mypage/setting.dart';

void newMemberCheck(BuildContext context) async {
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