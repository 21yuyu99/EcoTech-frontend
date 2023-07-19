import 'package:flutter/material.dart';
import '../../widget/bottom_bar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int degree = 26;
  final _ProvinceList = ['경기도', '강원도', '충청북도', '충청남도', '전라북도', '전라남도', '경상북도', '경상남도', '제주도'];
  var _SelectedProvinceValue = '경기도';
  final _CityList = ['서울시', '인천시', '부산시', '대구시', '대전시', '광주시', '...'];
  var _SelectedCityValue = '서울시';
  final _NumberList = ['1', '2', '3', '4', '5', '6'];
  var _SelectedNumberValue = '4';
  final _EatingHabitList = ['항상 남김', '때때로 남김', '거의 남기지 않음', '안 남김'];
  var _SelectedEatingHabitValue = '항상 남김';
  final _CommutingHabitList = ['자차 이용', '대중교통 이용', '도보/자전거 이용'];
  var _SelectedCommutingHabitValue = '자차 이용';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(selectedIdx: 1,),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("거주 지역", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(38, 0, 25, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffCDD6CC).withOpacity(.30),
                        ),
                        child: DropdownButton(
                          iconSize: 0,
                          value: _SelectedProvinceValue,
                          items: _ProvinceList.map(
                                (value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Center(child: Text(value, style: TextStyle(fontSize: 25,),)),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              _SelectedProvinceValue = value!;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffCDD6CC).withOpacity(.30),
                        ),
                        child: DropdownButton(
                          iconSize: 0,
                          value: _SelectedCityValue,
                          items: _CityList.map(
                                (value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 25),),
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
                  Text("생활 단위", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffCDD6CC).withOpacity(.30),
                        ),
                        child: DropdownButton(
                          iconSize: 0,
                          value: _SelectedNumberValue,
                          items: _NumberList.map(
                                (value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 30),),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              _SelectedNumberValue = value!;
                            });
                          },
                        ),
                      ),
                      Text(" 인 가구", style: TextStyle(fontSize: 30),),
                    ],
                  ),
                  Text("에어컨 평소 설정 온도", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                        decoration: BoxDecoration(
                            //border: Border.all(color:Colors.black,width: 2.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            color: Color(0xffCDD6CC).withOpacity(.30),
                        ),
                        child: Text(degree.toString(),style:TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 15,),
                      Text(
                        "℃",style: TextStyle(fontSize: 18),
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
                  Text("식사습관", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("음식을    ", style: TextStyle(fontSize: 20,
                          fontFamily: 'gaegu',fontWeight:FontWeight.w600),),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffCDD6CC).withOpacity(.30),
                        ),
                        child: DropdownButton(
                          iconSize: 0,
                          value: _SelectedEatingHabitValue,
                          items: _EatingHabitList.map(
                                (value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 20),),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              _SelectedEatingHabitValue = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Text("교통습관", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("출근할 때 주로    ", style: TextStyle(fontSize: 20,
                          fontFamily: 'gaegu',fontWeight:FontWeight.w600),),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffCDD6CC).withOpacity(.30),
                        ),
                        child: DropdownButton(
                          iconSize: 0,
                          value: _SelectedCommutingHabitValue,
                          items: _CommutingHabitList.map(
                                (value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 20),),
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
            ),
          ),
        ),
      ),
    );
  }
}
