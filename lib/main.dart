import 'dart:convert';
import 'Model/Login/LoginInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/Login/PermissionsEnum.dart';

TextEditingController _textAccount = TextEditingController();
TextEditingController _textPassword = TextEditingController();

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
        title: Text('Home Page'),
      ),
      body: Column(
        children:[
          TextField(
            controller: _textAccount,
            decoration: InputDecoration(
              hintText: '請輸入帳號',
            ),
          ),
          TextField(
            controller: _textPassword,
            decoration: InputDecoration(
              hintText: '請輸入密碼',
            ),
          ),
          ElevatedButton(
            child: Text('登入'),
            onPressed: () {
              GetHttpApi(context);
            },
          ),
        ]
      ),
    );
  }
}
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String memberName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('歡迎登入'+memberName),
      ),
    );
  }
}

//call api method
void GetHttpApi(BuildContext context) async{
  //basic param

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('http://192.168.17.110:8078/TonyTest2/api/login'));

  request.body = json.encode({
    "Account": _textAccount.text,
    "Password": _textPassword.text
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var bytes = await response.stream.toBytes();
    var responeText = utf8.decode(bytes);
    final json=jsonDecode(responeText);
    var loginInfo =LoginInfoModel.fromJson(json);

    if(loginInfo.IsSuccess){
      if(loginInfo.Auth== PermissionsEnum.All){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NextPage(),
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
      ShowToast(context);
    }
  }
  else {
    ShowToast(context);
  }
}
void ShowToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('登入失敗'),
      action: SnackBarAction(label: '確定', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}


