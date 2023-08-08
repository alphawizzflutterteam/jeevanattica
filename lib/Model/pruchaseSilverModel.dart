import 'dart:convert';
/// error : false
/// message : "silver Purchase successfully"
/// data : true

PruchaseSilverModel pruchaseSilverModelFromJson(String str) => PruchaseSilverModel.fromJson(json.decode(str));
String pruchaseSilverModelToJson(PruchaseSilverModel data) => json.encode(data.toJson());
class PruchaseSilverModel {
  PruchaseSilverModel({
      bool? error, 
      String? message, 
      bool? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  PruchaseSilverModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _error;
  String? _message;
  bool? _data;
PruchaseSilverModel copyWith({  bool? error,
  String? message,
  bool? data,
}) => PruchaseSilverModel(  error: error ?? _error,
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