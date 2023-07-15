import 'package:flutter/material.dart';
import 'package:frontend/widget/colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<String> imageList = ['assets/img/bottom_bar/home.png','assets/img/bottom_bar/record.png','assets/img/bottom_bar/market.png','assets/img/bottom_bar/mypage.png'];
  List<String> greenImageList = ['assets/img/bottom_bar/green_home.png','assets/img/bottom_bar/green_record.png','assets/img/bottom_bar/green_market.png','assets/img/bottom_bar/green_mypage.png'];
  List<String> menuNameList = ["홈","기록","스토어","마이페이지"];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: menuNameList.asMap().entries.map((entry) {
          int idx = entry.key;
          String val = entry.value;
          String img = idx == _selectedIndex ? greenImageList[idx] : imageList[idx];
          return BottomNavigationBarItem(
            icon: Image.asset(img,
              height: 40,
              width: 40,
            ),
            label: val,
          );
        }).toList(),
        selectedItemColor: AppColor.primaryColor,
        currentIndex: _selectedIndex,
        unselectedItemColor: AppColor.greyColor,
        unselectedFontSize: 16,
        selectedFontSize: 16,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (int value){
          setState(() {
            _selectedIndex = value;
          });
        },
      ),

      // child: Container(
        //     height: 90,
        //     margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        //     decoration: BoxDecoration(
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.lightGreen.withOpacity(0.7),
        //           spreadRadius: 4,
        //           blurRadius: 8,
        //           offset: Offset(0, 100),
        //         )
        //       ],
        //     ),
      );
  }
}

