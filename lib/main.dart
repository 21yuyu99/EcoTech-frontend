import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '에코테크',
      home: Home(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              Text('누적 절약 금액', style: Theme.of(context).textTheme.headlineLarge,),
              InkWell(
                onTap: (){
                },
                child: Image.asset('assets/img/piggy_bank.png'),
              ),
              Text('$_money 원', style: Theme.of(context).textTheme.headlineMedium,),
            ],
          ),
          Column(

          ),
          Column(

          )
        ],
      )
    );
  }
}

//
// class Home extends StatelessWidget {
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             InkWell(
//               onTap: (){
//               },
//               child: Image.asset('assets/img/piggy_bank.png'),
//             )
//           ],
//         )
//       )
//     );
//   }
// }
