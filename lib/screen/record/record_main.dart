import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/screen/record/check_page.dart';
import 'package:frontend/screen/record/result.dart';
import 'package:frontend/utils/settings_check.dart';
import 'package:frontend/widget/bottom_bar.dart';
import '../../utils/user_info.dart';
import 'package:http/http.dart' as http;

class RecordMain extends StatefulWidget {
  const RecordMain({super.key});

  @override
  State<RecordMain> createState() => _RecordMainState();
}

class _RecordMainState extends State<RecordMain> {
  // Future<String> alreadySaved() async{
  //   final user = await get_user(true,false);
  //   var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/user/check');
  //   var response = await http.post(url,body:{
  //       "user_id" : user[0]
  //   });
  //   return response.body;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIdx: 1,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(44, 189, 15, 0.2),
                    blurRadius:5.0,
                    offset: Offset(0,8),
                  ),
                ],
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 35,fontFamily: 'MainFont',fontWeight: FontWeight.w500),
                      padding: EdgeInsets.symmetric(vertical: 30),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Color(0xffF1FFEE),
                      foregroundColor: Colors.black
                  ),
                  onPressed: () async {
                    final user_info = await settingCheck();
                    final Map parsed = json.decode(user_info);
                    if(parsed['status'] == 200){
                      print(parsed);
                      if(parsed['save_check'] == 1){
                        Fluttertoast.showToast(
                          msg: "오늘 하루 체크를 이미 했어요!",
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0,
                          textColor: Colors.black,
                          backgroundColor: Colors.white,
                        );
                      }
                      else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CheckPage(carhabit: parsed['car_habit'],)),
                        );
                      }
                    }
                    else{
                      Fluttertoast.showToast(
                        msg: "서버 오류",
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 16.0,
                        textColor: Colors.black,
                        backgroundColor: Colors.white,
                      );
                    }
                  },
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("오늘 하루 체크"),
                      SizedBox(width: 15,),
                      Image.asset('assets/img/record/circle_check.png',width: 30,),
                    ],
                  )
              ),
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(255, 214, 0, 0.2),
                    blurRadius:8.0,
                    offset: Offset(0,5),
                  ),
                ],
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 35,fontFamily: 'MainFont',fontWeight: FontWeight.w500),
                      padding: EdgeInsets.symmetric(vertical: 30),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Color(0xffFFFCEE),
                      foregroundColor: Colors.black
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ResultPage()),
                    );
                  },
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("기록 결과 보기"),
                      SizedBox(width: 15,),
                      Image.asset('assets/img/record/note.png',width: 45,),
                    ],
                  )
              ),
            ),
          ],
        ),
      )
    );
  }
}
