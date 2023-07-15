import 'package:flutter/material.dart';
import 'package:frontend/widget/colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List iconList = [Icon(Icons.home),Icon(Icons.edit_note),Icon(Icons.eco),Icon(Icons.person)];
  List<String> menuNameList = ["홈","기록","스토어","마이페이지"];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [
        BoxShadow(
          color: Colors.lightGreen.withOpacity(0.7),
          spreadRadius: 4,
          blurRadius: 8,
          offset: Offset(0, 100),
        )]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: menuNameList.asMap().entries.map((entry) {
            int idx = entry.key;
            String val = entry.value;
            return BottomNavigationBarItem(
              icon: iconList[idx],
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
          iconSize: 28,
          onTap: (int value){
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      )

      );
  }
}

