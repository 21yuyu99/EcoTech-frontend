import 'package:flutter/material.dart';
import 'package:frontend/widget/bottom_bar.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomBar(selectedIdx: 0,),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 45),
          child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.233,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('누적 절약 금액', style: TextStyle(fontSize: 26)),
                          SizedBox(height: 5,),
                          Image.asset('assets/img/piggy_bank.png', width: 70, height: 70,),
                          SizedBox(height: 9,),
                          Row(
                            children: [
                              Text('0', style: TextStyle(fontSize: 18, fontFamily: 'gaegu',fontWeight: FontWeight.w700)),
                              SizedBox(width: 3,),
                              Text("원", style: TextStyle(fontSize: 18, fontFamily: 'gaegu',color: Color(0xffB9A060))),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text('   내 절감량', style: TextStyle(fontSize: 26)),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Image.asset('assets/img/plug.png', width: 80, height: 83,),
                                  Row(
                                    children: [
                                      Text('0', style: TextStyle(fontSize: 18, fontFamily: 'gaegu',fontWeight: FontWeight.w700)),
                                      SizedBox(width: 3,),
                                      Text("kWh", style: TextStyle(fontSize: 18, fontFamily: 'gaegu',color: Color(0xffB9A060))),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset('assets/img/cloud_co2.png', width: 60, height: 82,),
                                  Row(
                                    children: [
                                      Text('0', style: TextStyle(fontSize: 18, fontFamily: 'gaegu',fontWeight: FontWeight.w700)),
                                      SizedBox(width: 3,),
                                      Text("gCO₂e", style: TextStyle(fontSize: 18, fontFamily: 'gaegu',color: Color(0xffB9A060))),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 15,),
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width : MediaQuery.of(context).size.width,
                          alignment: Alignment.bottomCenter,
                          child: Text("LV.1", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,fontFamily: 'gaegu')),
                        ),
                        Positioned(
                            left: MediaQuery.of(context).size.width*0.5+15,
                            bottom:20,
                            child: Image.asset('assets/img/notification.png', width:18, height: 18,))
                      ],
                    ),
                    Padding(
                        padding : EdgeInsets.only(left : MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                        child: Container(
                          child: Image.asset('assets/img/sprout_and_barren_land.png',
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.463,
                          ),
                        )
                    )
                  ],
                ),
              ]
          ),
        )
    );
  }
}