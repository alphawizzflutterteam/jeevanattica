import 'dart:convert';
/// error : false
/// message : "Update Succesfully"
/// data : []
/// otp : 980177

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());
class LoginModel {
  LoginModel({
      bool? error, 
      String? message, 
      List<dynamic>? data, 
      int? otp,}){
    _error = error;
    _message = message;
    _data = data;
    _otp = otp;
}

  LoginModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(v);
      });
    }
    _otp = json['otp'];
  }
  bool? _error;
  String? _message;
  List<dynamic>? _data;
  int? _otp;
LoginModel copyWith({  bool? error,
  String? message,
  List<dynamic>? data,
  int? otp,
}) => LoginModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
  otp: otp ?? _otp,
);
  bool? get error => _error;
  String? get message => _message;
  List<dynamic>? get data => _data;
  int? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['otp'] = _otp;
    return map;
  }

}