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
