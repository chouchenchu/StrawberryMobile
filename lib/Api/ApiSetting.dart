import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/Login/LoginInfoModel.dart';
import '../Model/Login/PermissionsEnum.dart';
import '../View/BetInfoView.dart';
import '../main.dart';


Future<LoginInfoModel> GetLoginApi(String account,String password) async{
  //basic param
  LoginInfoModel loginInfo=LoginInfoModel(Name: "",Auth: PermissionsEnum.All,IsSuccess: false);
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('http://192.168.17.110:8078/TonyTest2/api/login'));

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

Future<bool> SetBetAmountApi(String amount,String memberid) async{
  //basic param
  LoginInfoModel loginInfo=LoginInfoModel(Name: "",Auth: PermissionsEnum.All,IsSuccess: false);
  bool result=false;

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('http://192.168.17.110:8078/TonyTest2/api/bet'));

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