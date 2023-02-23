import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('登入'),
          onPressed: () {
           GetHttpApi(context);
          },
        ),
      ),
    );
  }
}
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('登入成功'),
      ),
    );
  }
}

//call api method
void GetHttpApi(BuildContext context) async{
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request('GET', Uri.parse('http://192.168.17.110:8078/TonyTest2/api/Login/Tony,11'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    //print(await response.stream.bytesToString());
    //var jsonResponse = json.decode(request.body);
    var bytes = await response.stream.toBytes();
    var responeText = utf8.decode(bytes);
    if(responeText=="登入成功"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextPage()),
      );
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


