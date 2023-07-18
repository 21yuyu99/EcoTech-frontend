import 'package:flutter/material.dart';
import '../../widget/bottom_bar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _ProvinceList = ['경기도', '강원도', '충청북도', '충청남도', '전라북도', '전라남도', '경상북도', '경상남도', '제주도'];
  var _SelectedProvinceValue = '경기도';
  final _CityList = ['서울시', '인천시', '부산시', '대구시', '대전시', '광주시', '...'];
  var _SelectedCityValue = '서울시';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(selectedIdx: 1,),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("거주 지역", style: TextStyle(fontSize: 30),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton(
                      value: _SelectedProvinceValue,
                      items: _ProvinceList.map(
                          (value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _SelectedProvinceValue = value!;
                        });
                      },
                    ),
                    DropdownButton(
                      value: _SelectedCityValue,
                      items: _CityList.map(
                            (value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _SelectedCityValue = value!;
                        });
                      },
                    ),
                  ],
                ),
                Text("생활 단위", style: TextStyle(fontSize: 30),),
                Row(

                ),
                Text("에어컨 평소 설정 온도", style: TextStyle(fontSize: 30),),
                Text("식사습관", style: TextStyle(fontSize: 30),),
                Text("교통습관", style: TextStyle(fontSize: 30),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
