import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
            height: 90,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.lightGreen.withOpacity(0.7),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: Offset(0, 100),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child : Image.asset('assets/img/bar_home_hi.png'),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child : Text('홈'),
                          )
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        children: [
                          Image.asset('assets/img/bar_record.png'),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child : Text('기록'),
                          )
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Column(
                        children: [
                          Image.asset('assets/img/bar_market.png'),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
                            child : Text('스토어'),
                          )
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        children: [
                          Image.asset('assets/img/bar_mypage.png'),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                            child : Text('마이페이지'),
                          )
                        ],
                      )
                  ),
              ],
            )
        ),
      ),
    );
  }
}

