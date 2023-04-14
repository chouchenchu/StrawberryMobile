import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/ApiSetting.dart';
import '../Common/DialogService.dart';

class CommonSettingView extends StatelessWidget {

  TextEditingController _textAmount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Initial();
    return Scaffold(
      appBar: AppBar(
        title: Text('設定基本參數'),
      ),
        body:  Column(
            children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '賭金基準金:',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                  SizedBox(width: 10),//增加text與TextField間距
                  Expanded(
                    child:
                    TextField(
                      controller: _textAmount,
                      decoration: InputDecoration(
                        hintText: '請輸入賭金基準金',
                      ),

                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        child: Text('登記'),
                        onPressed: () async{
                          var result = await SetCommonBetAmountApi(_textAmount.text);
                          if(result){
                            ShowToast(context,'修改成功!');
                          }
                          else
                            ShowToast(context, '修改失敗');
                            Initial();//更新資訊
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 200),
                ],
              ),
              //DataTable
            ])
    );
  }
Future<void> Initial() async {
  _textAmount.text=await GetCommonBetAmountApi();
}
}