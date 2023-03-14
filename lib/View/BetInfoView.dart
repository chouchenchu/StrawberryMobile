import 'package:flutter/material.dart';

import '../Api/ApiSetting.dart';
import '../Common/DialogService.dart';

TextEditingController _textAmount = TextEditingController();
//TextEditingController _textPassword = TextEditingController();

class BetInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String memberName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('歡迎登入'+memberName),
      ),
      body: Column(
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '今日剩下賭金:',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
                SizedBox(width: 10),//增加text與TextField間距
                Expanded(
                    child:
                    TextField(
                      controller: _textAmount,
                      decoration: InputDecoration(
                        hintText: '請輸入最後賭金',
                      ),
                    ),
                )
              ],
            ),
            ElevatedButton(
              child: Text('登記'),
              onPressed: () async{
                var result = await SetBetAmountApi(_textAmount.text,"1");
                if(result){
                  ShowToast(context,'登錄成功!');
                  _textAmount.text="";
                }
                else
                  ShowToast(context, '登錄失敗');
              },
            ),
          ]
      ),
    );
  }
}