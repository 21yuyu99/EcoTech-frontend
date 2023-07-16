import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
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
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("저장",style: TextStyle(color: Colors.black,fontSize: 23),),
              ),
              ],
          ),
          SizedBox(height: 20,)
        ]
      );
    },
  );
}