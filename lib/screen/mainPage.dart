import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/widget/bottom_bar.dart';
import 'package:http/http.dart' as http;
import '../utils/user_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
bool level_msg = false;
String? money;
String? electronic;
String? co2;
Future post_info() async {
  final user = await get_user(true,false);
  var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/show/showaccum');
  var response = await http.post(url,body:{
      "user_id" : user[0]
  });
  final Map parsed = json.decode(response.body);
  if(parsed["status"] == 200){
    parsed["electronic"];
    setState(() {
      var temp = parsed["accum"]["money"];
      double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?money = temp.ceil().toString():money = double.parse(temp.toStringAsFixed(2)).toString();
      temp = parsed["accum"]["electronic"];
      double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?electronic = temp.ceil().toString():electronic = double.parse(temp.toStringAsFixed(2)).toString();
      temp = parsed["accum"]["co2"];
      double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?co2 = temp.ceil().toString():co2 = double.parse(temp.toStringAsFixed(2)).toString();
      // money = "150,0000000";
      // co2 = "150,0000000";
    });
    return parsed;

  }
  else{
    Fluttertoast.showToast(
      msg: "데이터 불러오기 오류",
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
      textColor: Colors.black,
      backgroundColor: Colors.white);
  }
}

@override
void initState() {
  super.initState();
  post_info();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomBar(selectedIdx: 0,),
        floatingActionButton: level_msg?Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.31,
              right: 20,left: 20
          ),
          width: 280,
          height: 60,
          child: FloatingActionButton(
            onPressed: (){},
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1,color: Color(0xffFFD600)),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                )),
            elevation: 0,
            child: Column(
              children: [
                Align(alignment: Alignment.topRight,child: TextButton(onPressed: (){
                  setState(() {
                    level_msg = false;
                  });
                },
                    style: TextButton.styleFrom(minimumSize: Size.zero,
                      padding: EdgeInsets.only(right: 20,top: 15),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ), child: Text("x",style: TextStyle(color: Colors.black),)),),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Align(alignment: Alignment.topCenter,
                    child: Text("환경 보호 활동으로 레벨을 올려보세요!",
                      style: TextStyle(color: Colors.black,
                          height: 0.7
                      ),),),
                )
              ],
            ),
          ),
        ):null,
        body:SingleChildScrollView(
          child:  Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 40),
            child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.35,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('누적 절약 금액', style: TextStyle(fontSize: 26)),
                            SizedBox(height: 5,),
                            Image.asset('assets/img/piggy_bank.png', width: 50, height: 50,),
                            SizedBox(height: 9,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(money??"loading", style: TextStyle(fontSize: 18, fontFamily: 'gaegu',fontWeight: FontWeight.w700)),
                                SizedBox(width: 3,),
                                Text("원", style: TextStyle(fontSize: 18, fontFamily: 'gaegu',color: Color(0xffB9A060))),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 15),
                              child: Text('내 절감량', style: TextStyle(fontSize: 26)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Image.asset('assets/img/plug.png', width: 35, height: 60,),
                                    Row(
                                      children: [
                                        Text(electronic??"loading", style: TextStyle(fontSize: 18, fontFamily: 'gaegu',fontWeight: FontWeight.w700)),
                                        SizedBox(width: 3,),
                                        Text("kWh", style: TextStyle(fontSize: 18, fontFamily: 'gaegu',color: Color(0xffB9A060))),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(width: 15,),
                                Column(
                                  children: [
                                    Image.asset('assets/img/cloud_co2.png', width: 40, height: 60,),
                                    Row(
                                      children: [
                                        Text(co2??"loading", style: TextStyle(fontSize: 18, fontFamily: 'gaegu',fontWeight: FontWeight.w700)),
                                        SizedBox(width: 3,),
                                        Text("gCO₂e", style: TextStyle(fontSize: 18, fontFamily: 'gaegu',color: Color(0xffB9A060))),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 70,
                            width : MediaQuery.of(context).size.width,
                            alignment: Alignment.bottomCenter,
                            child: Text("LV.1", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,fontFamily: 'gaegu')),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width*0.5+15,
                            bottom:20,
                            child: InkWell(
                                onTap: (){
                                  setState(() {
                                    level_msg = true;
                                  });
                                },
                                child: Image.asset('assets/img/notification.png', width:18, height: 18,)),
                          )
                        ],
                      ),
                      Padding(
                          padding : EdgeInsets.only(top:20,left : MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                          child: Container(
                            child: Image.asset('assets/img/sprout_and_barren_land.png',
                              width: MediaQuery.of(context).size.width,
                            ),
                          )
                      )
                    ],
                  ),
                ]
            ),
          ),
        )
    );
  }
}