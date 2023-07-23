import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/widget/bottom_bar.dart';
import 'package:intl/intl.dart';
import '../../utils/user_info.dart';
import 'package:http/http.dart' as http;

class ByItemPage extends StatefulWidget {
  const ByItemPage({super.key});

  @override
  State<ByItemPage> createState() => _ByItemPageState();
}

class _ByItemPageState extends State<ByItemPage> {
  late bool carItem = true;
  bool isLoading = true;
  late final power = [];
  String? food;
  late final traffic = [];
  late final aircon = [];
  String? recycle;
  Future post_info() async {
    final user = await get_user(true,false);
    var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/show/showitem');
    var response = await http.post(url,body:{
      "user_id" : user[0]
    });
    final Map parsed = json.decode(response.body);
    if(parsed["status"]==200){
      setState(() {
        var f = NumberFormat('###,###,###,###');
        parsed["item"]["c_sum_m"] == 0 && parsed["car_habit"] == 0?carItem=false:carItem=true;
        power.add(f.format(parsed["item"]["e_sum_m"]));
        var temp = parsed["item"]["e_sum_e"];
        double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?power.add(temp.ceil().toString()):power.add(double.parse(temp.toStringAsFixed(2)).toString());
        temp = parsed["item"]["e_sum_c"];
        double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?power.add(temp.ceil().toString()):power.add(double.parse(temp.toStringAsFixed(2)).toString());
        temp = parsed["item"]["f_sum_c"];
        double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?food = temp.ceil().toString():food = double.parse(temp.toStringAsFixed(2)).toString();
        traffic.add(f.format(parsed["item"]["c_sum_m"]));
        temp = parsed["item"]["c_sum_c"];
        double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?traffic.add(temp.ceil().toString()):traffic.add(double.parse(temp.toStringAsFixed(2)).toString());
        aircon.add(f.format(parsed["item"]["a_sum_m"]));
        temp = parsed["item"]["a_sum_e"];
        double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?aircon.add(temp.ceil().toString()):aircon.add(double.parse(temp.toStringAsFixed(2)).toString());
        temp = parsed["item"]["a_sum_c"];
        double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?aircon.add(temp.ceil().toString()):aircon.add(double.parse(temp.toStringAsFixed(2)).toString());
        temp = parsed["item"]["g_sum_c"];
        double.parse(temp.toStringAsFixed(2)) - temp.ceil() == 0?recycle = temp.ceil().toString():recycle = double.parse(temp.toStringAsFixed(2)).toString();
        isLoading = false;
      });
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
      appBar: AppBar(
        title : Text("항목별 누적 절감량",
          style: TextStyle(color : Colors.black,
              fontSize: 26,fontWeight: FontWeight.w500),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(selectedIdx: 1,),
      body:
          isLoading?
              Center(
                child: CircularProgressIndicator(),
              ):
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/img/record/standby_power.png',width: 60,),
                      SizedBox(height: 15,),
                      Text("대기전력",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width*0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("금액",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                      SizedBox(height: 5,),
                      Text("전력",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                      SizedBox(height: 5,),
                      Text("온실가스",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${power[0]} 원",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                      SizedBox(height: 5,),
                      Text("${power[1]} kWh",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),SizedBox(height: 5,),

                      Text("${power[2]} gCO₂e",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height:1.0,
            decoration: BoxDecoration(
              color:Color(0xffCDD6CC),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xffCDD6CC),
                  blurRadius:5.0,
                  offset: Offset(0,3),
                ),
              ],
            ),
            margin: EdgeInsets.only(top:15),
            width:MediaQuery.of(context).size.width,
          ),//standby power
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/img/record/food_waste.png',width: 40,),
                      SizedBox(height: 8,),
                      Text("음식물",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
               Container(
                 padding: EdgeInsets.only(left: 25),
                 width: MediaQuery.of(context).size.width*0.3,
                 child:  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("온실가스",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                   ],
                 ),
               ),
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${food} gCO₂e",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height:1.0,
            decoration: BoxDecoration(
              color:Color(0xffCDD6CC),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xffCDD6CC),
                  blurRadius:5.0,
                  offset: Offset(0,3),
                ),
              ],
            ),
            margin: EdgeInsets.only(top:15),
            width:MediaQuery.of(context).size.width,
          ),
          Visibility(
            visible: carItem,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     Container(
                       width: MediaQuery.of(context).size.width*0.3,
                       child:  Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Image.asset('assets/img/record/car.png',width: 70,),
                           SizedBox(height: 5,),
                           Text("교통",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                         ],
                       ),
                     ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.3,
                        padding: EdgeInsets.only(left: 28),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("금액",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                            SizedBox(height: 5,),
                            Text("온실가스",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${traffic[0]} 원",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                            SizedBox(height: 5,),
                            Text("${traffic[1]} gCO₂e",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height:1.0,
                  decoration: BoxDecoration(
                    color:Color(0xffCDD6CC),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color(0xffCDD6CC),
                        blurRadius:5.0,
                        offset: Offset(0,3),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top:15),
                  width:MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ),
          Container(
            padding:  carItem?EdgeInsets.only(top: 20):null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/img/record/air_conditioner.png',width: 60,),
                      SizedBox(height: 5,),
                      Text("에어컨",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  padding: EdgeInsets.only(left: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("금액",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                      SizedBox(height: 5,),
                      Text("전력",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                      SizedBox(height: 5,),
                      Text("온실가스",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${aircon[0]} 원",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                      SizedBox(height: 5,),
                      Text("${aircon[1]} kWh",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),SizedBox(height: 5,),

                      Text("${aircon[2]} gCO₂e",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                    ],
                  ),
                )
              ],
            ),
          ),//에어컨
          Container(
            height:1.0,
            decoration: BoxDecoration(
              color:Color(0xffCDD6CC),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xffCDD6CC),
                  blurRadius:5.0,
                  offset: Offset(0,3),
                ),
              ],
            ),
            margin: EdgeInsets.only(top:15),
            width:MediaQuery.of(context).size.width,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width:MediaQuery.of(context).size.width*0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/img/record/recycle.png',width: 45,),
                      SizedBox(height: 10,),
                      Text("분리배출",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
                Container(
                  width:MediaQuery.of(context).size.width*0.3,
                  padding: EdgeInsets.only(left: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("온실가스",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${recycle} gCO₂e",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      )
    );
  }
}
