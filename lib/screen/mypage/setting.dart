import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/mypage/mypage.dart';
import '../../utils/colors.dart';
import '../../widget/bottom_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int degree = 26;
  final _ProvinceList = ['서울특별시', '부산광역시', '대구광역시', '인천광역시', '광주광역시', '대전광역시', '울산광역시', '경기도', "강원도",
  "충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주특별자치도","세종특별자치시"];
  var _SelectedProvinceValue = '서울특별시';
  final _ProvinceCodeList = [11, 21, 22, 23, 24, 25, 26, 31, 32, 33, 34, 35, 36, 37, 38, 39, 41];
  final _CityList = ['서울시', '인천시', '부산시', '대구시', '대전시', '광주시', '...'];
  var _SelectedCityValue = '서울시';
  final _CommutingHabitList = ['자차 이용', '대중교통 이용', '도보/자전거 이용','재택근무'];
  var _SelectedCommutingHabitValue = '자차 이용';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(selectedIdx: 3,),
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
        margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.76),
        child: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
        onPressed: () {
          Fluttertoast.showToast(
              msg: "저장되었습니다",
              gravity: ToastGravity.BOTTOM,
              fontSize: 16.0,
              textColor: Colors.black,
              backgroundColor: Colors.white,
          );Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyPage()));
          },
        backgroundColor: AppColor.accentColor,
        child: Text("저장",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                         padding: EdgeInsets.symmetric(vertical: 0,horizontal: 35),
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
                             print(index);
                             print(_ProvinceCodeList[index]);
                             var url = Uri.http('ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036', 'user/region');
                             var response = await http.post(url, body: {
                               "sido" : _SelectedProvinceValue,
                               "code" : _ProvinceCodeList[index]
                             });
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
                               _SelectedCityValue = value!;
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
                height: MediaQuery.of(context).size.height*0.3,
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
                          child: Text(degree.toString(),style:TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
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
                                  degree++;
                                });
                              },
                              padding: EdgeInsets.all(0),
                              iconSize: 35,
                              icon: Image.asset('assets/img/record/up_arrow.png'),
                            ),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  degree--;
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
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.3,
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
      ),
    );
  }
}
