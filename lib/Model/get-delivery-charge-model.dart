import 'dart:convert';
GetDeliveryChargeModel getDeliveryChargeModelFromJson(String str) => GetDeliveryChargeModel.fromJson(json.decode(str));
String getDeliveryChargeModelToJson(GetDeliveryChargeModel data) => json.encode(data.toJson());
class GetDeliveryChargeModel {
  GetDeliveryChargeModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetDeliveryChargeModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
GetDeliveryChargeModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => GetDeliveryChargeModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? userId, 
      String? address, 
      String? type, 
      String? amount, 
      String? deliveryCharges, 
      String? makingCharges, 
      num? gstPercentage, 
      String? totalAmount, 
      String? amountWithGst,}){
    _userId = userId;
    _address = address;
    _type = type;
    _amount = amount;
    _deliveryCharges = deliveryCharges;
    _makingCharges = makingCharges;
    _gstPercentage = gstPercentage;
    _totalAmount = totalAmount;
    _amountWithGst = amountWithGst;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _address = json['address'];
    _type = json['type'];
    _amount = json['amount'];
    _deliveryCharges = json['delivery_charges'];
    _makingCharges = json['making_charges'];
    _gstPercentage = json['gst_percentage'];
    _totalAmount = json['total_amount'];
    _amountWithGst = json['amount_with_gst'];
  }
  String? _userId;
  String? _address;
  String? _type;
  String? _amount;
  String? _deliveryCharges;
  String? _makingCharges;
  num? _gstPercentage;
  String? _totalAmount;
  String? _amountWithGst;
Data copyWith({  String? userId,
  String? address,
  String? type,
  String? amount,
  String? deliveryCharges,
  String? makingCharges,
  num? gstPercentage,
  String? totalAmount,
  String? amountWithGst,
}) => Data(  userId: userId ?? _userId,
  address: address ?? _address,
  type: type ?? _type,
  amount: amount ?? _amount,
  deliveryCharges: deliveryCharges ?? _deliveryCharges,
  makingCharges: makingCharges ?? _makingCharges,
  gstPercentage: gstPercentage ?? _gstPercentage,
  totalAmount: totalAmount ?? _totalAmount,
  amountWithGst: amountWithGst ?? _amountWithGst,
);
  String? get userId => _userId;
  String? get address => _address;
  String? get type => _type;
  String? get amount => _amount;
  String? get deliveryCharges => _deliveryCharges;
  String? get makingCharges => _makingCharges;
  num? get gstPercentage => _gstPercentage;
  String? get totalAmount => _totalAmount;
  String? get amountWithGst => _amountWithGst;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['address'] = _address;
    map['type'] = _type;
    map['amount'] = _amount;
    map['delivery_charges'] = _deliveryCharges;
    map['making_charges'] = _makingCharges;
    map['gst_percentage'] = _gstPercentage;
    map['total_amount'] = _totalAmount;
    map['amount_with_gst'] = _amountWithGst;
    return map;
  }

}