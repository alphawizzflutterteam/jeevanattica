import 'dart:convert';
/// error : false
/// message : "Mobile Number Updated"
/// data : true

NumberModel numberModelFromJson(String str) => NumberModel.fromJson(json.decode(str));
String numberModelToJson(NumberModel data) => json.encode(data.toJson());
class NumberModel {
  NumberModel({
      bool? error, 
      String? message, 
      bool? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  NumberModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _error;
  String? _message;
  bool? _data;
NumberModel copyWith({  bool? error,
  String? message,
  bool? data,
}) => NumberModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  bool? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}