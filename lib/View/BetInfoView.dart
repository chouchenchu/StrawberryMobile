import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../Api/ApiSetting.dart';
import '../Common/DialogService.dart';
import '../Model/Bet/GetBetInfo.dart';
import 'CommonSettingView.dart';


class BetInfoView extends StatefulWidget  {
  const BetInfoView({required Key? key}) : super(key: key);
  @override
  _BetInfoHomePage createState() =>new _BetInfoHomePage();
}

class _BetInfoHomePage extends State<BetInfoView>{
  //basic param
  //List<Map<String, dynamic>>  _betInfoModelList =[];
  GetBetInfoModel? _data;
  String _profitLossTotal="0";
  String _memberid='1';
  TextEditingController _textAmount = TextEditingController();
  //basic method
  @override
  void  initState() {
    super.initState();
    RefreshData();

  }
  Future<void> RefreshData() async {
    final betInfoModelList = await GetBetAmountApi("2023",_memberid,false);
    setState(() {
      //_betInfoModelList = betInfoModelList;
      _data=betInfoModelList;
      _profitLossTotal = (_data?.profitLossTotal ?? _profitLossTotal);
    });
  }
  //widget
  @override
  Widget build(BuildContext context) {
    String memberName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text('歡迎登入'+memberName),
      ),
      body:
      Column(
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
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 100,
                    child: ElevatedButton(
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
                  ),
                ),
                SizedBox(width: 200),

                //SizedBox(width: 16,),
                ElevatedButton(
                  child: Text('設定'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommonSettingView(),
                        //settings: RouteSettings(
                        //arguments: loginInfo.Name,
                        // )
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '預計賺/賠金: '+_profitLossTotal,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      child: Text('結算'),
                      onPressed: () async {
                        var result = await ShowTwoAlertDialog(context,'確定要結算?');
                        if(result){
                          var amount = await GetProfitLoss(_memberid);
                          if(int.parse(amount)>0)
                            ShowAlertDialog(context,'總共賺了'+amount);
                          else
                            ShowAlertDialog(context,'總共賠了'+amount);
                          ShowToast(context,'結算成功!');
                        }
                        else
                          ShowToast(context, '結算失敗');

                      },
                    ),
                  ),
                ),
              ],
            ),
            //DataTable
            SizedBox(height: 50),
            Expanded(child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:
              GetDataTable()
            ))
          ])
      );
  }
StatelessWidget GetDataTable(){

  List<DataRow>? rows = _data?.betInfoList?.map((item) => DataRow(cells: [
    DataCell(Text(item.createTime)),
    DataCell(Text(item.amount)),
    DataCell(Text(item.profitLoss)),
  ])).toList();

  if (_data != null && _data?.betInfoList != null) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('日期')),
        DataColumn(label: Text('金額')),
        DataColumn(label: Text('損益金')),
      ],
        rows: rows ?? [],
    );
  }
  else {
    return const Text('資料為空');
  }
}
}



