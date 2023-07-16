import 'package:flutter/material.dart';
import 'package:frontend/screen/record/check_page.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/widget/bottom_bar.dart';

class RecordMain extends StatefulWidget {
  const RecordMain({super.key});

  @override
  State<RecordMain> createState() => _RecordMainState();
}

class _RecordMainState extends State<RecordMain> {
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
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CheckPage()),
                    );
                  },
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("오늘 하루 체크"),
                      SizedBox(width: 15,),
                      Image.asset('assets/img/record/circle_check.png',width: 40,),
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
                  onPressed: (){},
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
