import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});
  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  List<String> checkTextList = [
    "사용하지 않는 플러그를 모두 뽑았나요?",
    "오늘 음식을 남기지 않고 드셨나요?",
    "출근길에 대중교통을 이용하셨나요?",
  ];
  List<bool> yesList = [
    false,false,false
  ];
  List<bool> noList = [
    true,true,true
  ];
  int degree = 26;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
              ),
              SizedBox(
                height: 25,
              ),
              ...checkTextList.map((question) => Column(
                children: [
                  Text(question,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("예",style: TextStyle(fontSize: 20,fontFamily: 'gaegu',fontWeight:FontWeight.w500),),
                      Transform.scale(
                        scale: 1.4,
                        child: Checkbox(
                          activeColor : Colors.black,
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 2.0, color: Colors.black),
                          ),
                          value: yesList[checkTextList.indexOf(question)],
                          onChanged:(value){
                            setState(() {
                              yesList[checkTextList.indexOf(question)] = !yesList[checkTextList.indexOf(question)];
                              noList[checkTextList.indexOf(question)] = !noList[checkTextList.indexOf(question)];
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text("아니오",style: TextStyle(fontSize: 20,fontFamily: 'gaegu',fontWeight:FontWeight.w500)),
                      Transform.scale(
                        scale:1.4,
                        child :Checkbox(
                          activeColor : Colors.black,
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 2.0, color: Colors.black),
                          ),
                          value: noList[checkTextList.indexOf(question)],
                          onChanged:(value){
                            setState(() {
                              yesList[checkTextList.indexOf(question)] = !yesList[checkTextList.indexOf(question)];
                              noList[checkTextList.indexOf(question)] = !noList[checkTextList.indexOf(question)];
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset('assets/img/record/grey_line.png'),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              ).toList(),
              Text("에어컨을 몇도로 설정하고 생활하셨나요?",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color:Colors.black,width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        )
                    ),
                    child: Text(degree.toString(),style:TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                  ),
                  SizedBox(width: 15,),
                  Text(
                    "℃",style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){
                          setState(() {
                            degree++;
                          });
                        },
                        padding: EdgeInsets.all(0),
                        iconSize: 35,
                        icon: Image.asset('assets/img/record/up_arrow.png'),
                      ),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              degree--;
                            });
                          },
                          iconSize: 30,
                          icon: Image.asset('assets/img/record/down_arrow.png'),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        );
  }
}