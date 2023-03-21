import 'dart:convert';
import 'Api/ApiSetting.dart';
import 'Common/DialogService.dart';
import 'Model/Login/LoginInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/Login/PermissionsEnum.dart';
import 'View/BetInfoView.dart';

TextEditingController _textAccount = TextEditingController(text: 'sa');
TextEditingController _textPassword = TextEditingController(text: '11');
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomePage(),
    );
  }
}

//page地方
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登入'),
      ),
      body: Column(
        children:[
          Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text(
      '帳號:',
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
    ),
    SizedBox(width: 10),//增加text與TextField間距
    Expanded(
        child: TextField(
          controller: _textAccount,
          decoration: InputDecoration(
            hintText: '請輸入帳號',
          ),
        ),
    )
  ],
),
          SizedBox(height: 20),
          Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text(
      '密碼:',
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
    ),
    SizedBox(width: 10),//增加text與TextField間距
    Expanded(
        child: TextField(
          controller: _textPassword,
          decoration: InputDecoration(
            hintText: '請輸入密碼',
          ),
        ),
    )
  ],
),
          SizedBox(height:40),
          ElevatedButton(
            child: Text('登入'),
            onPressed: () async {
             var loginInfo = await GetLoginApi(_textAccount.text,_textPassword.text);
             if(loginInfo.IsSuccess){
               if(loginInfo.Auth== PermissionsEnum.All){
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => BetInfoView(key: null,),
                       settings: RouteSettings(
                         arguments: loginInfo.Name,
                       )
                   ),
                 );
               }
               else{
               }
             }
             else {
               ShowToast(context,'登入失敗');
             }
            },
          ),
        ]
      ),
    );
  }
}






