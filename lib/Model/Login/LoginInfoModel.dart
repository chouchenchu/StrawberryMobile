import 'package:http/http.dart';
import 'PermissionsEnum.dart';

class LoginInfoModel {
  String Name = "";
  PermissionsEnum Auth = PermissionsEnum.All;
  bool IsSuccess = false;

  LoginInfoModel({required this.Name, required this.Auth, required this.IsSuccess});

  factory LoginInfoModel.fromJson( Map<String, dynamic> json) {
    return LoginInfoModel(
      Name: json['name'],
      Auth: PermissionsEnum.values[json['auth']],
      IsSuccess: json['isSuccess'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': Name,
      'Auth': Auth,
      'IsSuccess': IsSuccess,
    };
  }
}

