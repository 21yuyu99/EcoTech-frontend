import 'package:flutter/material.dart';

import '../widget/colors.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 26),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width : MediaQuery.of(context).size.width*0.1,
                    child: IconButton(
                      onPressed:(){},
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColor.accentColor,
                        size: 35,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height:  MediaQuery.of(context).size.height*0.15,
                        width : MediaQuery.of(context).size.width*0.6,
                        alignment: Alignment.center,
                        child: Text(
                            "오늘 하루 Check",
                            style:TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: AppColor.primaryColor
                            )
                        ),
                      ),
                      Positioned(
                          bottom: -2,
                          left:12,
                          child: Container(
                            child: Image(
                              image: AssetImage('assets/img/record/title_line.png'),
                            ),
                          )
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    style:ElevatedButton.styleFrom(
                        backgroundColor: AppColor.accentColor,
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                        textStyle : TextStyle(
                          color:Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        )
                    ),
                    child: Text("저장"),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}