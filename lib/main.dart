import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screen/record/record_main.dart';
import 'package:frontend/screen/record/result.dart';
import 'package:frontend/widget/bottom_bar.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '에코테크',
      home: Home(),
      theme: ThemeData(
          fontFamily: 'MainFont'
      ),
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _money = 0;
  int _electricity = 0;
  int _co2 = 0;
  int _level = 1;

  void _set_money(){
    setState(() {
      _money = _money + 100;        //상수는 그날 절약 금액에 대한 변수로 후에 대체
    });
  }

  void _set_electricity(){
    setState(() {
      _electricity = _electricity + 100;        //상수는 그날 절약 전력량에 대한 변수로 후에 대체
    });
  }

  void _set_co2(){
    setState(() {
      _co2 = _co2 + 100;            //상수는 그날 절약 이산화탄소량에 대한 변수로 후에 대체
    });
  }

  void _set_level(){
    setState(() {
      _level = _level + 1;          // 레벨이 올라갈 때 마다 setstate
    });
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        bottomNavigationBar: const BottomBar(selectedIdx: 0,),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top:40,bottom:15),
            child: Column(
              children: [
                const SizedBox(height: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('누적 절약 금액', style: Theme.of(context).textTheme.headlineMedium,),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ResultPage()),
                            );
                          },
                          child: Image.asset('assets/img/piggy_bank.png', width: 80, height: 80,),
                        ),
                        Text('$_money 원', style: Theme.of(context).textTheme.headlineMedium,),
                      ],
                    ),
                    Column(
                      children: [
                        Text('내 절감량', style: Theme.of(context).textTheme.headlineMedium,),
                        Row(
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ResultPage()),
                                    );
                                  },
                                  child: Image.asset('assets/img/plug.png', width: 100, height: 100,),
                                ),
                                Text('$_electricity kwh', style: Theme.of(context).textTheme.headlineSmall,)
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ResultPage()),
                                    );
                                  },
                                  child: Image.asset('assets/img/cloud_co2.png', width: 100, height: 100,),
                                ),
                                Text('$_co2 gCO2e', style: Theme.of(context).textTheme.headlineSmall,)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("LV.$_level", style: Theme.of(context).textTheme.headlineMedium,),
                    const Padding(padding: EdgeInsets.all(5)),
                    Image.asset('assets/img/notification.png', width: 30, height: 30,)
                  ],
                ),
                Image.asset('assets/img/sprout_and_barren_land.png', height: 420, width: 500,)
              ],
            ),
          ),
        ),
      );
  }
}