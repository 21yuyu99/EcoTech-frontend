import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screen/record/by_item.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/widget/bottom_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../utils/user_info.dart';

class ResultPage extends StatefulWidget {

  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  var today;
  var month;
  var accum;
  String? messages;
  Future post_info() async {
    final user = await get_user(true,false);
    var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/show/showrecord');
    var response = await http.post(url,body:{
      "user_id" : user[0]
    });
    final Map parsed = json.decode(response.body);
    if(parsed["status"] == 200){
      today = parsed["record"]["today"];
      month = parsed["record"]["month"];
      accum = parsed["record"]["accum"];
      messages = parsed["record"]["messages"].values.toList()[0];
      setState(() {
        var temp = today;
        var f = NumberFormat('###,###,###,###');
        double.parse(temp["money"].toStringAsFixed(2)) - temp["money"].ceil() == 0?today["money"] = f.format(temp["money"].ceil()):today["money"] = f.format(double.parse(temp["money"].toStringAsFixed(2)));
        double.parse(temp["co2"].toStringAsFixed(2)) - temp["co2"].ceil() == 0?today["co2"] = temp["co2"].ceil().toString():today["co2"] = double.parse(temp["co2"].toStringAsFixed(2)).toString();
        double.parse(temp["elec"].toStringAsFixed(2)) - temp["elec"].ceil() == 0?today["elec"] = temp["elec"].ceil().toString():today["elec"] = double.parse(temp["elec"].toStringAsFixed(2)).toString();
        temp = month;
        double.parse(temp["money"].toStringAsFixed(2)) - temp["money"].ceil() == 0?month["money"] = f.format(temp["money"].ceil()):month["money"] = f.format(double.parse(temp["money"].toStringAsFixed(2)));
        double.parse(temp["co2"].toStringAsFixed(2)) - temp["co2"].ceil() == 0?month["co2"] = temp["co2"].ceil().toString():month["co2"] = double.parse(temp["co2"].toStringAsFixed(2)).toString();
        double.parse(temp["elec"].toStringAsFixed(2)) - temp["elec"].ceil() == 0?month["elec"] = temp["elec"].ceil().toString():month["elec"] = double.parse(temp["elec"].toStringAsFixed(2)).toString();
        temp = accum;
        double.parse(temp["money"].toStringAsFixed(2)) - temp["money"].ceil() == 0?accum["money"] = f.format(temp["money"].ceil()):accum["money"] = f.format(double.parse(temp["money"].toStringAsFixed(2)));
        double.parse(temp["co2"].toStringAsFixed(2)) - temp["co2"].ceil() == 0?accum["co2"] = temp["co2"].ceil().toString():accum["co2"] = double.parse(temp["co2"].toStringAsFixed(2)).toString();
        double.parse(temp["elec"].toStringAsFixed(2)) - temp["elec"].ceil() == 0?accum["elec"] = temp["elec"].ceil().toString():accum["elec"] = double.parse(temp["elec"].toStringAsFixed(2)).toString();
      });
      // return parsed;
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
        margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.76),
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
      body: today == null||month==null||accum == null?Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
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
                                showDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: 35, // Adjust this as needed
                                          child: Dialog(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                            child: Container(
                                              padding:EdgeInsets.only(top:15,left: 5,right: 5),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text('  추산된 값으로 실제 값과 다를 수 있습니다  ',style: TextStyle(fontSize: 16),),
                                                  SizedBox(
                                                    width: 50,
                                                    height: 40,
                                                    child: TextButton(
                                                      child: Text('닫기', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),),
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
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/img/record/piggy_bank.png',width: 100,),
                            Row(
                              children: [
                                Container(
                                  margin : EdgeInsets.only(right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("오늘", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                      SizedBox(height: 15,),
                                      Text("이번 달", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                      SizedBox(height: 15,),
                                      Text("누적", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${today["money"]} 원",style: TextStyle(fontFamily: "gaegu",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),),
                                    SizedBox(height: 15,),
                                    Text("${month["money"]} 원",style: TextStyle(fontFamily: "gaegu",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),),
                                    SizedBox(height: 15,),
                                    Text("${accum["money"]} 원",style: TextStyle(fontFamily: "gaegu",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    margin: EdgeInsets.only(top: 20,bottom: 20),
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
                              messages??"loading",
                              style: TextStyle(fontSize: 20,height: 1.5)),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:25,bottom:5,top:10),
                        child: Text("내 절감량",
                          style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(bottom: 10),
                                  child: Image.asset('assets/img/record/electricity.png',width: 40,),
                                ),
                                Container(
                                    child:
                                    Row(
                                      children: [
                                        Container(
                                          margin : EdgeInsets.only(right: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("오늘", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                              SizedBox(height: 15,),
                                              Text("이번 달", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                              SizedBox(height: 15,),
                                              Text("누적", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${today["elec"]} kWh"??"loading",style: TextStyle(fontFamily: "gaegu",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),),
                                            SizedBox(height: 15,),
                                            Text("${month["elec"]} kWh"??"loading",style: TextStyle(fontFamily: "gaegu",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),),
                                            SizedBox(height: 15,),
                                            Text("${accum["elec"]} kWh"??"loading",style: TextStyle(fontFamily: "gaegu",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),),
                                          ],
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(bottom: 10),
                                  child:Image.asset('assets/img/record/green_gas.png',width: 50,height: 78,),
                                ),
                                Container(
                                    child:
                                    Row(
                                      children: [
                                        Container(
                                          margin : EdgeInsets.only(right: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("오늘", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                              SizedBox(height: 15,),
                                              Text("이번 달", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                              SizedBox(height: 15,),
                                              Text("누적", style: TextStyle(fontFamily: "gaegu", fontSize: 16),),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${today["co2"]} gCO₂e"??"loading",style: TextStyle(fontFamily: "gaegu",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),),
                                            SizedBox(height: 15,),
                                            Text("${month["co2"]} gCO₂e"??"loading",style: TextStyle(fontFamily: "gaegu",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),),
                                            SizedBox(height: 15,),
                                            Text("${accum["co2"]} gCO₂e"??"loading",style: TextStyle(fontFamily: "gaegu",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),),
                                          ],
                                        )
                                      ],
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ])),
      )
    );
  }
}
