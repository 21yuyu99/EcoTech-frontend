import 'package:flutter/material.dart';
import 'package:frontend/widget/bottom_bar.dart';

class ByItemPage extends StatefulWidget {
  const ByItemPage({super.key});

  @override
  State<ByItemPage> createState() => _ByItemPageState();
}

class _ByItemPageState extends State<ByItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("항목별 누적 절감량",
          style: TextStyle(color : Colors.black,
              fontSize: 26,fontWeight: FontWeight.w500),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(selectedIdx: 1,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset('assets/img/record/standby_power.png',width: 60,),
                    SizedBox(height: 15,),
                    Text("대기전력",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("금액",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                    SizedBox(height: 5,),
                    Text("전력",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                    SizedBox(height: 5,),
                    Text("온실가스",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("220원",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                    SizedBox(height: 5,),
                    Text("1.07kWh",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),SizedBox(height: 5,),

                    Text("36.5gCO₂e",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height:1.0,
            decoration: BoxDecoration(
              color:Color(0xffCDD6CC),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xffCDD6CC),
                  blurRadius:5.0,
                  offset: Offset(0,3),
                ),
              ],
            ),
            margin: EdgeInsets.only(top:15),
            width:MediaQuery.of(context).size.width,
          ),//standby power
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset('assets/img/record/food_waste.png',width: 60,),
                    SizedBox(height: 15,),
                    Text("음식물",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("온실가스",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("99.17gCO₂e",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height:1.0,
            decoration: BoxDecoration(
              color:Color(0xffCDD6CC),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xffCDD6CC),
                  blurRadius:5.0,
                  offset: Offset(0,3),
                ),
              ],
            ),
            margin: EdgeInsets.only(top:15),
            width:MediaQuery.of(context).size.width,
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset('assets/img/record/car.png',width: 60,),
                    Text("교통",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("금액",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                    SizedBox(height: 5,),
                    Text("온실가스",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4,794원",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                    SizedBox(height: 5,),
                    Text("42.6gCO₂e",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height:1.0,
            decoration: BoxDecoration(
              color:Color(0xffCDD6CC),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xffCDD6CC),
                  blurRadius:5.0,
                  offset: Offset(0,3),
                ),
              ],
            ),
            margin: EdgeInsets.only(top:15),
            width:MediaQuery.of(context).size.width,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset('assets/img/record/air_conditioner.png',width: 60,),
                    SizedBox(height: 5,),
                    Text("에어컨",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("금액",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                    SizedBox(height: 5,),
                    Text("전력",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                    SizedBox(height: 5,),
                    Text("온실가스",style: TextStyle(fontSize: 16,fontFamily: 'gaegu'),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("244원",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                    SizedBox(height: 5,),
                    Text("1.14kWh",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),SizedBox(height: 5,),

                    Text("7.26gCO₂e",style: TextStyle(fontSize: 16,fontFamily: 'gaegu',fontWeight: FontWeight.w700),),
                  ],
                ),
              ],
            ),
          ),//에어컨
        ],
      )
    );
  }
}