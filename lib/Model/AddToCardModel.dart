import 'dart:convert';
/// error : false
/// message : "Add Successfully"
/// data : []

AddToCardModel addToCardModelFromJson(String str) => AddToCardModel.fromJson(json.decode(str));
String addToCardModelToJson(AddToCardModel data) => json.encode(data.toJson());
class AddToCardModel {
  AddToCardModel({
      bool? error, 
      String? message, 
      List<dynamic>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  AddToCardModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(v);
      });
    }
  }
  bool? _error;
  String? _message;
  List<dynamic>? _data;
AddToCardModel copyWith({  bool? error,
  String? message,
  List<dynamic>? data,
}) => AddToCardModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}