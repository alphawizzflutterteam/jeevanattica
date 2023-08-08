import 'dart:convert';
CatelogDetailsModel catelogDetailsModelFromJson(String str) => CatelogDetailsModel.fromJson(json.decode(str));
String catelogDetailsModelToJson(CatelogDetailsModel data) => json.encode(data.toJson());
class CatelogDetailsModel {
  CatelogDetailsModel({
      bool? error, 
      String? message,
      String? text,
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
    _text = text;
}

  CatelogDetailsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _text = json['text'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message , _text;
  List<Data>? _data;
CatelogDetailsModel copyWith({  bool? error,
  String? message,
  String? text,
  List<Data>? data,
}) => CatelogDetailsModel(  error: error ?? _error,
  message: message ?? _message,
  text: text ?? _text,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  String? get text => _text;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['text'] = _text;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      String? image, 
      String? price, 
      String? weight, 
      String? mrp, 
      String? createAt,}){
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _price = price;
    _weight = weight;
    _mrp = mrp;
    _createAt = createAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _price = json['price'];
    _weight = json['weight'];
    _mrp = json['mrp'];
    _createAt = json['create_at'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _image;
  String? _price;
  String? _weight;
  String? _mrp;
  String? _createAt;
Data copyWith({  String? id,
  String? title,
  String? description,
  String? image,
  String? price,
  String? weight,
  String? mrp,
  String? createAt,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  image: image ?? _image,
  price: price ?? _price,
  weight: weight ?? _weight,
  mrp: mrp ?? _mrp,
  createAt: createAt ?? _createAt,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  String? get price => _price;
  String? get weight => _weight;
  String? get mrp => _mrp;
  String? get createAt => _createAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['price'] = _price;
    map['weight'] = _weight;
    map['mrp'] = _mrp;
    map['create_at'] = _createAt;
    return map;
  }

}