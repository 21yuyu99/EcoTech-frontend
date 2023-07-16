import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  List iconList = [Icon(Icons.home),Icon(Icons.edit_note),Icon(Icons.eco),Icon(Icons.person)];
  List<String> menuNameList = ["홈","기록","스토어","마이페이지"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(44, 189, 15, 0.26),
              blurRadius:5.0,
              offset: Offset(0,5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: menuNameList.asMap().entries.map((entry) {
            int idx = entry.key;
            String val = entry.value;
            // _selectedIndex == idx?
            return BottomNavigationBarItem(
              icon: iconList[idx],
              label: val,
            );
          }).toList(),
          selectedItemColor: AppColor.primaryColor,
          selectedIconTheme: IconThemeData(
            shadows: <Shadow>[Shadow(color: Color.fromRGBO(44, 189, 15, 0.5),
                blurRadius: 10.0,offset: Offset(0,6))],),
          currentIndex: _selectedIndex,
          unselectedItemColor: AppColor.greyColor,
          unselectedFontSize: 16,
          selectedFontSize: 16,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 28,
          elevation: 0,
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

