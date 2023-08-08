import 'dart:convert';
/// error : false
/// message : "get Successfully"
/// data : [{"id":"10","promo_code":"New","message":"this is wellcome","start_date":"2022-05-05","end_date":"2022-05-19","no_of_users":"4","minimum_order_amount":"200","discount":"1","discount_type":"percentage","max_discount_amount":"1","repeat_usage":"1","no_of_repeat_usage":"1","image":"uploads/media/2022/banner_2.png","status":"1","date_created":"2022-05-25 17:30:51"}]

GetCouponModel getCouponModelFromJson(String str) => GetCouponModel.fromJson(json.decode(str));
String getCouponModelToJson(GetCouponModel data) => json.encode(data.toJson());
class GetCouponModel {
  GetCouponModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetCouponModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetCouponModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetCouponModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

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

/// id : "10"
/// promo_code : "New"
/// message : "this is wellcome"
/// start_date : "2022-05-05"
/// end_date : "2022-05-19"
/// no_of_users : "4"
/// minimum_order_amount : "200"
/// discount : "1"
/// discount_type : "percentage"
/// max_discount_amount : "1"
/// repeat_usage : "1"
/// no_of_repeat_usage : "1"
/// image : "uploads/media/2022/banner_2.png"
/// status : "1"
/// date_created : "2022-05-25 17:30:51"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? promoCode, 
      String? message, 
      String? startDate, 
      String? endDate, 
      String? noOfUsers, 
      String? minimumOrderAmount, 
      String? discount, 
      String? discountType, 
      String? maxDiscountAmount, 
      String? repeatUsage, 
      String? noOfRepeatUsage, 
      String? image, 
      String? status, 
      String? dateCreated,}){
    _id = id;
    _promoCode = promoCode;
    _message = message;
    _startDate = startDate;
    _endDate = endDate;
    _noOfUsers = noOfUsers;
    _minimumOrderAmount = minimumOrderAmount;
    _discount = discount;
    _discountType = discountType;
    _maxDiscountAmount = maxDiscountAmount;
    _repeatUsage = repeatUsage;
    _noOfRepeatUsage = noOfRepeatUsage;
    _image = image;
    _status = status;
    _dateCreated = dateCreated;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _promoCode = json['promo_code'];
    _message = json['message'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _noOfUsers = json['no_of_users'];
    _minimumOrderAmount = json['minimum_order_amount'];
    _discount = json['discount'];
    _discountType = json['discount_type'];
    _maxDiscountAmount = json['max_discount_amount'];
    _repeatUsage = json['repeat_usage'];
    _noOfRepeatUsage = json['no_of_repeat_usage'];
    _image = json['image'];
    _status = json['status'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _promoCode;
  String? _message;
  String? _startDate;
  String? _endDate;
  String? _noOfUsers;
  String? _minimumOrderAmount;
  String? _discount;
  String? _discountType;
  String? _maxDiscountAmount;
  String? _repeatUsage;
  String? _noOfRepeatUsage;
  String? _image;
  String? _status;
  String? _dateCreated;
Data copyWith({  String? id,
  String? promoCode,
  String? message,
  String? startDate,
  String? endDate,
  String? noOfUsers,
  String? minimumOrderAmount,
  String? discount,
  String? discountType,
  String? maxDiscountAmount,
  String? repeatUsage,
  String? noOfRepeatUsage,
  String? image,
  String? status,
  String? dateCreated,
}) => Data(  id: id ?? _id,
  promoCode: promoCode ?? _promoCode,
  message: message ?? _message,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  noOfUsers: noOfUsers ?? _noOfUsers,
  minimumOrderAmount: minimumOrderAmount ?? _minimumOrderAmount,
  discount: discount ?? _discount,
  discountType: discountType ?? _discountType,
  maxDiscountAmount: maxDiscountAmount ?? _maxDiscountAmount,
  repeatUsage: repeatUsage ?? _repeatUsage,
  noOfRepeatUsage: noOfRepeatUsage ?? _noOfRepeatUsage,
  image: image ?? _image,
  status: status ?? _status,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get promoCode => _promoCode;
  String? get message => _message;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get noOfUsers => _noOfUsers;
  String? get minimumOrderAmount => _minimumOrderAmount;
  String? get discount => _discount;
  String? get discountType => _discountType;
  String? get maxDiscountAmount => _maxDiscountAmount;
  String? get repeatUsage => _repeatUsage;
  String? get noOfRepeatUsage => _noOfRepeatUsage;
  String? get image => _image;
  String? get status => _status;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['promo_code'] = _promoCode;
    map['message'] = _message;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['no_of_users'] = _noOfUsers;
    map['minimum_order_amount'] = _minimumOrderAmount;
    map['discount'] = _discount;
    map['discount_type'] = _discountType;
    map['max_discount_amount'] = _maxDiscountAmount;
    map['repeat_usage'] = _repeatUsage;
    map['no_of_repeat_usage'] = _noOfRepeatUsage;
    map['image'] = _image;
    map['status'] = _status;
    map['date_created'] = _dateCreated;
    return map;
  }

}