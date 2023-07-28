import 'dart:convert';
import 'package:frontend/utils/user_info.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/mypage/mypage.dart';
import '../../utils/colors.dart';
import '../../widget/bottom_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../mainPage.dart';

class Settings extends StatefulWidget {
  Settings({super.key,
    required this.first,
  });
  bool first;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int summerDegree = 26;
  int winterDegree = 20;
  final _ProvinceList = ['시/도','서울특별시', '부산광역시', '대구광역시', '인천광역시', '광주광역시', '대전광역시', '울산광역시', '경기도', "강원도",
  "충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주특별자치도","세종특별자치시"];
  var _SelectedProvinceValue= '시/도';
  final _ProvinceCodeList = ['0','11', '21', '22', '23', '24', '25', '26', '31', '32', '33', '34', '35', '36', '37', '38', '39', '41'];
  List _CityList = ['시/군/구'];
  var _SelectedCityValue = '시/군/구';
  final _CommutingHabitList = ['자차 이용', '대중교통 이용', '도보/자전거 이용','재택근무'];
  var _SelectedCommutingHabitValue = '자차 이용';
  final _WeatherHabitList = ['에어컨을 틈','난방을 틈','해당 없음'];
  var _WeatherHabitValue = '해당 없음';

  Future<int> save_post() async {
    final user_info = await get_user(true,true);
    var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/user/info');
    var response = await http.post(url,body:{
      "user_id" : user_info[0],
      "metro" : _SelectedProvinceValue,
      "city" : _SelectedCityValue,
      "air_habit" : summerDegree.toString(),
      "car_habit" : _SelectedCommutingHabitValue == "자차 이용"?"1":"0",
      "nickname" : user_info[1],
    });
    return response.statusCode;
  }
  bool msgOpen = true;
  bool first = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: first ? null : const BottomBar(selectedIdx: 3,),
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
        width:70,
        height: 45,
        margin: first ? EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.85):EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.76),
        child: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
        onPressed: () async {
          if(_SelectedProvinceValue !="시/도" && _SelectedCityValue!="시/군/구"){
            final post = await save_post();
            if(post == 200){
              Fluttertoast.showToast(
                msg: "저장되었습니다",
                gravity: ToastGravity.BOTTOM,
                fontSize: 16.0,
                textColor: Colors.black,
                backgroundColor: Colors.white,
              );
              first?
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home())):
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPage()));
            }
            else{
              Fluttertoast.showToast(
                msg: "저장 실패",
                gravity: ToastGravity.BOTTOM,
                fontSize: 16.0,
                textColor: Colors.black,
                backgroundColor: Colors.white,
              );
            }
          }
          else{
            Fluttertoast.showToast(
              msg: "모든 항목을 채워주세요",
              gravity: ToastGravity.BOTTOM,
              fontSize: 16.0,
              textColor: Colors.black,
              backgroundColor: Colors.white,
            );
          }
          },
        backgroundColor: AppColor.accentColor,
        child: Text("저장",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    height: MediaQuery.of(context).size.height*0.3,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child:  Text("거주 지역", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
                        ),
                        SizedBox(height:50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffCDD6CC).withOpacity(.30),
                              ),
                              child: DropdownButton(
                                iconSize: 0,
                                value: _SelectedProvinceValue,
                                underline: SizedBox.shrink(),
                                alignment: Alignment.center,
                                items: _ProvinceList.map(
                                      (value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Center(child: Text(value, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) async {
                                  setState(()  {
                                    _SelectedProvinceValue = value!;
                                  });
                                  int index = _ProvinceList.indexOf(_SelectedProvinceValue);
                                  if(index!=0){
                                    var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/user/region');
                                    var response = await http.post(url,body:{
                                      "sido" : _SelectedProvinceValue,
                                      "code" : _ProvinceCodeList[index],
                                    });
                                    print(response.statusCode);
                                    final Map parsed = json.decode(response.body);
                                    List<dynamic> city = ['시/군/구'];
                                    city.addAll(parsed["city"]);
                                    setState(() {
                                      _SelectedCityValue = "시/군/구";
                                      _CityList = city;
                                    });
                                    // _SelectedCityValue
                                  }
                                  else{
                                    setState(() {
                                      _SelectedCityValue = "시/군/구";
                                      _CityList = ["시/군/구"];
                                    });
                                  }

                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 35),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffCDD6CC).withOpacity(.30),
                              ),
                              child: DropdownButton(
                                iconSize: 0,
                                alignment: Alignment.center,
                                value: _SelectedCityValue,
                                underline: SizedBox.shrink(),
                                items: _CityList.map(
                                      (value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _SelectedCityValue = value as String;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.23,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30,top:15),
                          child: Text("요즘 날씨에는", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
                        ),
                        SizedBox(height:40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffCDD6CC).withOpacity(.30),
                              ),
                              child: DropdownButton(
                                iconSize: 0,
                                value: _WeatherHabitValue,
                                alignment: Alignment.center,
                                underline: SizedBox.shrink(),
                                items: _WeatherHabitList.map(
                                      (value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _WeatherHabitValue = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _WeatherHabitValue == "에어컨을 틈"?Container(
                    height: MediaQuery.of(context).size.height*0.23,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text("에어컨 평소 설정 온도", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
                        ),
                        SizedBox(height:30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 13),
                              decoration: BoxDecoration(
                                //border: Border.all(color:Colors.black,width: 2.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                color: Color(0xffCDD6CC).withOpacity(.30),
                              ),
                              child: Text(summerDegree.toString(),style:TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "℃",style: TextStyle(fontSize: 18,fontFamily: 'gaegu'),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      summerDegree++;
                                    });
                                  },
                                  padding: EdgeInsets.all(0),
                                  iconSize: 35,
                                  icon: Image.asset('assets/img/record/up_arrow.png'),
                                ),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      summerDegree--;
                                    });
                                  },
                                  iconSize: 30,
                                  icon: Image.asset('assets/img/record/down_arrow.png'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ):Text(""),
                  _WeatherHabitValue == "난방을 틈"?Container(
                    height: MediaQuery.of(context).size.height*0.23,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text("난방 평소 설정 온도", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
                        ),
                        SizedBox(height:30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 13),
                              decoration: BoxDecoration(
                                //border: Border.all(color:Colors.black,width: 2.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                color: Color(0xffCDD6CC).withOpacity(.30),
                              ),
                              child: Text(winterDegree.toString(),style:TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "℃",style: TextStyle(fontSize: 18,fontFamily: 'gaegu'),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      winterDegree++;
                                    });
                                  },
                                  padding: EdgeInsets.all(0),
                                  iconSize: 35,
                                  icon: Image.asset('assets/img/record/up_arrow.png'),
                                ),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      winterDegree--;
                                    });
                                  },
                                  iconSize: 30,
                                  icon: Image.asset('assets/img/record/down_arrow.png'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ):Text(""),
                  Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text("교통습관", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
                        ),
                        SizedBox(height:40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("출근할 때 주로    ", style: TextStyle(fontSize: 20,
                                fontFamily: 'gaegu',fontWeight:FontWeight.w600),),
                            Container(
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffCDD6CC).withOpacity(.30),
                              ),
                              child: DropdownButton(
                                iconSize: 0,
                                value: _SelectedCommutingHabitValue,
                                alignment: Alignment.center,
                                underline: SizedBox.shrink(),
                                items: _CommutingHabitList.map(
                                      (value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _SelectedCommutingHabitValue = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            widget.first?Visibility(
                visible: msgOpen,
                child: Positioned(
                    top: MediaQuery.of(context).size.height*0.33,
                    child: Container(
                        width: MediaQuery.of(context).size.width*0.94,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color.fromRGBO(44, 189, 15, 0.26),
                              blurRadius:5.0,
                              offset: Offset(0,5),
                            ),
                          ],
                        ),
                        margin:EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03,right:MediaQuery.of(context).size.width*0.03),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20,),
                              Text("환영합니다!",style: TextStyle(fontSize: 25,),),
                              SizedBox(height: 20,),
                              Text("원활한 서비스 이용을 위해",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                              SizedBox(height: 10,),
                              Text("기본 설정을 먼저 해주세요:)",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                              SizedBox(height: 20,),
                              Text("예상 절약 금액, 에니저 절감량을 계산하는 데 사용됩니다.",style: TextStyle(fontSize: 16,height: 1.5),),
                              SizedBox(height: 20,),
                              ElevatedButton(onPressed: (){
                                setState(() {
                                  msgOpen = false;
                                  widget.first = false;
                                  first = true;
                                });
                              }, child: Text("확인했어요",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                style: ElevatedButton.styleFrom(padding:EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                    backgroundColor: AppColor.primaryColor),),
                            ],
                          ),
                        )
                    ))):Text(""),
          ],
        )
      ),
    );
  }
}
