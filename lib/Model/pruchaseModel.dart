import 'dart:convert';
/// error : false
/// message : "Gold Purchase successfully"
/// data : true

PruchaseModel pruchaseModelFromJson(String str) => PruchaseModel.fromJson(json.decode(str));
String pruchaseModelToJson(PruchaseModel data) => json.encode(data.toJson());
class PruchaseModel {
  PruchaseModel({
      bool? error, 
      String? message, 
      bool? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  PruchaseModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _error;
  String? _message;
  bool? _data;
PruchaseModel copyWith({  bool? error,
  String? message,
  bool? data,
}) => PruchaseModel(  error: error ?? _error,
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