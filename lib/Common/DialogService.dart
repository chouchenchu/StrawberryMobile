import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


  void ShowToast(BuildContext context,String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(label: '確定', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

Future<bool> ShowTwoAlertDialog(BuildContext context, String msg) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('確認'),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.of(context).pop(false); // 回傳false
            },
          ),
          TextButton(
            child: Text('確定'),
            onPressed: () {
              Navigator.of(context).pop(true); // 回傳true
            },
          ),
        ],
      );
    },
  ).then((value) {    // 回傳值處理
    if(value==true)
      return true;
    else
      return false;

  });
}


Future<void> ShowAlertDialog(BuildContext context, String msg) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('確認'),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: Text('確定'),
            onPressed: () {
              Navigator.of(context).pop(true); // 回傳true
            },
          ),
        ],
      );
    },
  ).then((value) {    // 回傳值處理
  });
}