import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/Bet/GetBetInfo.dart';
import '../Model/Login/LoginInfoModel.dart';
import '../Model/Login/PermissionsEnum.dart';
import '../View/BetInfoView.dart';
import '../main.dart';

//Initial
String apuUrl="http://192.168.17.110:8078/TonyTest2/api";
//登入
Future<LoginInfoModel> GetLoginApi(String account,String password) async{
  //basic param
  LoginInfoModel loginInfo=LoginInfoModel(Name: "",Auth: PermissionsEnum.All,IsSuccess: false);
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse(apuUrl+'/login'));

  request.body = json.encode({
    "Account": account,
    "Password": password
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var bytes = await response.stream.toBytes();
    var responeText = utf8.decode(bytes);
    final json=jsonDecode(responeText);
    loginInfo =LoginInfoModel.fromJson(json);

  return loginInfo;
  }
  return loginInfo;
}

//設定個人賭金
Future<bool> SetBetAmountApi(String amount,String memberid) async{
  //basic param
  LoginInfoModel loginInfo=LoginInfoModel(Name: "",Auth: PermissionsEnum.All,IsSuccess: false);
  bool result=false;

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse(apuUrl+'/bet'));

  request.body = json.encode({
    "Amount": amount,
    "MemberID": memberid
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var bytes = await response.stream.toBytes();
    var responeText = utf8.decode(bytes);
    final json=jsonDecode(responeText);
    result = json.toString().toLowerCase()=='true';
    //loginInfo =LoginInfoModel.fromJson(json);

    return result;
  }
  return result;
}
//取得時間內未結賭金
Future<GetBetInfoModel?> GetBetAmountApi(String selectYear,String memberid,bool isSettlement) async{
  //basic param
  List<Map<String,dynamic>> _data=[];
  GetBetInfoModel? data;
  bool result=false;

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse(apuUrl+'/bet/GetInfo'));
  request.headers.addAll(headers);

  request.body = json.encode({
    "SelectYear": selectYear,
    "MemberID": memberid,
    "IsSettlement": isSettlement
  });

  final response = await request.send();
  if (response.statusCode == 200) {
    var bytes = await response.stream.toBytes();
    var responeText = utf8.decode(bytes);
    final json=jsonDecode(responeText);
    var data = GetBetInfoModel.fromJson(json);
    //_data =List<Map<String,dynamic>>.from(json);

    return data;
  }
  return data;
}
//賭金基期 Common
Future<bool> SetCommonBetAmountApi(String amount) async{
  //basic param
  bool result=false;

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse(apuUrl+'/common'));

  request.body = json.encode({
    "BetAmount": amount
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var bytes = await response.stream.toBytes();
    var responeText = utf8.decode(bytes);
    final json=jsonDecode(responeText);
    result = json.toString().toLowerCase()=='true';
    //loginInfo =LoginInfoModel.fromJson(json);

    return result;
  }
  return result;
}
Future<String> GetCommonBetAmountApi() async{
  //basic param
  String result='0';

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse(apuUrl+'/common/GetBetAmount'));

  request.body ="";
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var bytes = await response.stream.toBytes();
    var responeText = utf8.decode(bytes);
    final json=jsonDecode(responeText);
    result = json.toString();
    //loginInfo =LoginInfoModel.fromJson(json);

    return result;
  }
  return result;
}
