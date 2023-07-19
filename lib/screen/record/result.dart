import 'package:flutter/material.dart';
import 'package:frontend/screen/record/by_item.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/widget/bottom_bar.dart';

class ResultPage extends StatefulWidget {

  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIdx: 1,),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xffFFEF98),
              blurRadius:6.0,
              offset: Offset(0,6),
            ),
          ],
        ),
        width:90,
        height: 45,
        margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.73),
        child: FloatingActionButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ByItemPage()),
            );
          },
          backgroundColor: AppColor.accentColor,
          child: Text("항목별 보기",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top:40,bottom:15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left:20),
                            child: Text("내가 절약한 금액 ",
                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),
                            ),
                          ),
                          GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              final Offset position = details.globalPosition;
                              final double margin = 20.0; // The desired margin value
                              showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return Stack(
                                    children: <Widget>[
                                      Positioned(
                                        left: 15, // Adjust this as needed
                                        right: 5,
                                        top: 30, // Adjust this as needed
                                        child: Dialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text('추산된 값으로 실제 값과 다를 수 있습니다.'),
                                                SizedBox(
                                                  width: 50,
                                                  height: 40,
                                                  child: TextButton(
                                                    child: Text('닫기', style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w900),),
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.all(0),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Image.asset('assets/img/alert.png', width: 15, height: 15,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left:25,right:50,top: 0),
                              child : Image.asset('assets/img/record/piggy_bank.png',width: 100,)
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text("오늘", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                  SizedBox(width: 50,),
                                  Text("5,268.2원",style: TextStyle(fontFamily: "gaegu",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Text("이번 달", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                  SizedBox(width: 50,),
                                  Text("10,536원",style: TextStyle(fontFamily: "gaegu",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Text("누적", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                  SizedBox(width: 50,),
                                  Text("168,582원",style: TextStyle(fontFamily: "gaegu",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(bottom:15,top:10),
                    decoration: BoxDecoration(
                      color : Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: AppColor.primaryColor,
                          width: 1.5,
                        ),
                        bottom: BorderSide(
                          color: AppColor.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color.fromRGBO(44, 189, 15, 0.2),
                          blurRadius:5.0,
                          offset: Offset(0,5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("오늘의 든든 상식",style: TextStyle(fontSize: 23,fontFamily: 'gaegu'),),
                            Image.asset("assets/img/record/fork.png",width: 45,),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                              "1인당 한 달에 배출하는 온실가스는 무려 1.06톤이라는 사실! 알고 계셨나요?",
                              style: TextStyle(fontSize: 20,height: 1.5)),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:25,bottom:5,top:15),
                        child: Text("내 절감량",
                          style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('assets/img/record/electricity.png',width: 40,),
                          Image.asset('assets/img/record/green_gas.png',width: 45,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("오늘", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                    SizedBox(width: 25,),
                                    Text("2.21kWh",style: TextStyle(fontFamily: "gaegu",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("이번 달", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                    SizedBox(width: 25,),
                                    Text("4.42kWh",style: TextStyle(fontFamily: "gaegu",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("누적", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                    SizedBox(width: 25,),
                                    Text("70.72kWh",style: TextStyle(fontFamily: "gaegu",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("오늘", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                    SizedBox(width: 25,),
                                    Text("185.5gCO₂e",style: TextStyle(fontFamily: "gaegu",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("이번 달", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                    SizedBox(width: 25,),
                                    Text("371gCO₂e",style: TextStyle(fontFamily: "gaegu",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("누적", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                    SizedBox(width: 25,),
                                    Text("5,936gCO₂e",style: TextStyle(fontFamily: "gaegu",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ])),
      )
    );
  }
}
