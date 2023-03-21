import 'dart:io';

import 'package:flutter/material.dart';

import '../Api/ApiSetting.dart';
import '../Common/DialogService.dart';
import '../Model/Bet/GetBetInfo.dart';


class BetInfoView extends StatefulWidget  {
  const BetInfoView({required Key? key}) : super(key: key);
  @override
  _BetInfoHomePage createState() =>new _BetInfoHomePage();
}

class _BetInfoHomePage extends State<BetInfoView>{
  //basic param
  List<Map<String, dynamic>>  _betInfoModelList =[];
  TextEditingController _textAmount = TextEditingController();
  //basic method
  @override
  void  initState() {
    super.initState();
    RefreshData();

  }
  Future<void> RefreshData() async {
    final betInfoModelList = await GetBetAmountApi("2023","1",false);
    setState(() {
      _betInfoModelList = betInfoModelList;
    });
  }
  //widget
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
            SizedBox(height: 50),
            ElevatedButton(
              child: Text('登記'),
              onPressed: () async{
                var result = await SetBetAmountApi(_textAmount.text,"1");
                if(result){
                  ShowToast(context,'登錄成功!');
                  _textAmount.text="";
                 initState();
                 //updateUI();
                }
                else
                  ShowToast(context, '登錄失敗');
                initState();//更新資訊
              },
            ),
            SizedBox(height: 50),
          DataTable(columns: const[
            DataColumn(label: Text('日期')),
            DataColumn(label: Text('金額')),
          ], rows: _betInfoModelList.map((item) => DataRow(cells: [
            DataCell(Text(item['createTime'])),
            DataCell(Text(item['amount'])),
          ])).toList()
          )

               ])

      );

  }

}

