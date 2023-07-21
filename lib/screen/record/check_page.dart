import 'package:flutter/material.dart';
import 'package:frontend/screen/record/result.dart';
import 'dart:convert';
import 'package:frontend/widget/bottom_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/colors.dart';
import '../../utils/user_info.dart';
import 'package:http/http.dart' as http;

class CheckPage extends StatefulWidget {
  const CheckPage({
    Key? key,
    required this.carhabit,
  }):super(key:key);
  final int carhabit;
  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  List<bool> yesList = [
    false,false,false,false
  ];
  List<bool> noList = [
    true,true,true,true
  ];
  int degree = 26;
  late var checkTextList;

  Future<String> post_save() async{
    final user = await get_user(true,false);
    var url = Uri.parse('http://ec2-13-209-22-145.ap-northeast-2.compute.amazonaws.com:3036/user/record');
    var response = await http.post(url,body:{
      "user_id" : user[0],
      "flug" : yesList[0] == true?"1":"0",
      "food" : yesList[1] == true?"1":"0",
      "car" : widget.carhabit == 0?"0":yesList[2] == true?"1":"0",
      "aircond" : degree.toString(),
      "garbage" : widget.carhabit == 0?yesList[2] == true?"1":"0":yesList[3] == true?"1":"0",
    });
    return response.body;
  }

  Future<void> savePopUp(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              side: BorderSide(color: Color(0xffFFF2B0),width: 5.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 30,width: 20,),
                Text("저장 후 수정이 불가합니다.",style: TextStyle(fontSize: 25),),
                SizedBox(height: 50,width: 20,),
                Text("저장하시겠습니까?",style: TextStyle(fontSize: 25)),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFF6C7),
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text("돌아가기",style: TextStyle(color: Colors.black,fontSize: 23),),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.accentColor,
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    ),
                    onPressed: () async {
                      final post = await post_save();
                      final Map parsed = json.decode(post);
                      if(parsed['status']==200){
                        print(parsed);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ResultPage()),
                        );
                      }
                      else{
                        Fluttertoast.showToast(
                          msg: "저장 실패",
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0,
                          textColor: Colors.black,
                          backgroundColor: Colors.white,
                        );
                      }
                    },
                    child: Text(
                      "저장",
                      style: TextStyle(color: Colors.black,fontSize: 23,
                      ),),
                  ),
                ],
              ),
              SizedBox(height: 20,)
            ]
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    widget.carhabit == 1?checkTextList = [
      "사용하지 않는 플러그를 모두 뽑았나요?",
      "오늘 음식을 남기지 않고 드셨나요?",
      "출근길에 대중교통을 이용하셨나요?",
      "분리배출을 잘 실천하셨나요?"
    ]:checkTextList = [
    "사용하지 않는 플러그를 모두 뽑았나요?",
    "오늘 음식을 남기지 않고 드셨나요?",
    "분리배출을 잘 실천하셨나요?"
    ];

    bool isSaved = false;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(63.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.only(top: 6),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.accentColor,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height:  MediaQuery.of(context).size.height*0.2,
                width : MediaQuery.of(context).size.width*0.65,
                padding: EdgeInsets.only(left: 6,bottom: 0),
                alignment: Alignment.centerLeft,
                child: Text(
                    "오늘 하루 Check",
                    style:TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primaryColor
                    )
                ),
              ),
              Positioned(
                  bottom: 43,
                  left:-8,
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/img/record/title_line.png'),
                    ),
                  )
              ),
            ],
          ),
          actions: [
            isSaved?Text(""):Container(
              margin: EdgeInsets.only(top:10,bottom: 8,right: 10),
              child: ElevatedButton(
                onPressed: ()=>savePopUp(context),
                style:ElevatedButton.styleFrom(
                    backgroundColor: AppColor.accentColor,
                    textStyle : TextStyle(
                      color:Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    )
                ),
                child: Text("저장"),
              ),
            )
          ],
        ),
      ),
        bottomNavigationBar: BottomBar(selectedIdx: 1,),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                ...checkTextList.map((question) => Container(
                  padding: EdgeInsets.only(top: 25),
                  child: Column(
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
                )
                ).toList(),
                SizedBox(height: 15,),
                Container(
                  child: Column(
                    children: [Text("에어컨을 몇도로 설정하고 생활하셨나요?",
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
                      ),],
                  ),
                )
              ],
            ),
          )
        ),
        );
  }
}