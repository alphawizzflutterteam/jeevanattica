import 'dart:convert';
/// error : false
/// message : "silver sell successfully"
/// data : true

SellSilverGoldModel sellSilverModelFromJson(String str) => SellSilverGoldModel.fromJson(json.decode(str));
String sellSilverModelToJson(SellSilverGoldModel data) => json.encode(data.toJson());
class SellSilverGoldModel {
  SellSilverGoldModel({
      bool? error, 
      String? message, 
      bool? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  SellSilverGoldModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _error;
  String? _message;
  bool? _data;
SellSilverGoldModel copyWith({  bool? error,
  String? message,
  bool? data,
}) => SellSilverGoldModel(  error: error ?? _error,
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