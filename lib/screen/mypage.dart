import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/bottom_bar.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomBar(selectedIdx: 1,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Text("거주 지역", style: TextStyle(fontSize: 30),),
            Row(

            ),
            Text("생활 단위", style: TextStyle(fontSize: 30),),
            Row(

            ),
            Text("에어컨 평소 설정 온도", style: TextStyle(fontSize: 30),),

          ],

        ),
      ),
    );
  }
}
