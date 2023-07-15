import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<String> imageList = ['assets/img/bottom_bar/home.png','assets/img/bottom_bar/record.png','assets/img/bottom_bar/market.png','assets/img/bottom_bar/mypage.png'];
  List<String> greeImageList = ['assets/img/bottom_bar/green_home.png','assets/img/bottom_bar/green_record.png','assets/img/bottom_bar/green_market.png','assets/img/bottom_bar/green_mypage.png'];
  List<bool> selectedMenu = [true,false,false,false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ...selectedMenu.map( (isSelected,index) =>
            // isSelected == true?Image.asset()
            // ).toList(),
          ],
        )
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
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //           Container(
        //               child: Column(
        //                 children: [
        //                   Container(
        //                     margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
        //                     child : Image.asset('assets/img/bottom_bar/green_home.png'),
        //                   ),
        //                   Container(
        //                     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        //                     child : Text('홈'),
        //                   )
        //                 ],
        //               )
        //           ),
        //           Container(
        //               margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        //               child: Column(
        //                 children: [
        //                   Image.asset('assets/img/bottom_bar/record.png'),
        //                   Container(
        //                     margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        //                     child : Text('기록'),
        //                   )
        //                 ],
        //               )
        //           ),
        //           Container(
        //               margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        //               child: Column(
        //                 children: [
        //                   Image.asset('assets/img/bottom_bar/market.png'),
        //                   Container(
        //                     margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
        //                     child : Text('스토어'),
        //                   )
        //                 ],
        //               )
        //           ),
        //           Container(
        //               margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        //               child: Column(
        //                 children: [
        //                   Image.asset('assets/img/bottom_bar/mypage.png'),
        //                   Container(
        //                     margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
        //                     child : Text('마이페이지'),
        //                   )
        //                 ],
        //               )
        //           ),
        //       ],
        //     )
        // ),
      ),
    );
  }
}

