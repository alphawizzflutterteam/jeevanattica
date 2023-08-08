/// error : false
/// message : "Withdrawl"
/// data : [{"id":"1","user_id":"251","amount":"2000.00","upi_id":" 8770496665@ybl","bank_name":"","account_number":"","ifsc_code":"","account_holder_name":"","is_approved":"0","created_at":"2022-10-18 17:01:52","updated_at":"2022-10-18 17:01:52"}]

class WithdrawHistory {
  WithdrawHistory({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  WithdrawHistory.fromJson(dynamic json) {
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
WithdrawHistory copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => WithdrawHistory(  error: error ?? _error,
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

/// id : "1"
/// user_id : "251"
/// amount : "2000.00"
/// upi_id : " 8770496665@ybl"
/// bank_name : ""
/// account_number : ""
/// ifsc_code : ""
/// account_holder_name : ""
/// is_approved : "0"
/// created_at : "2022-10-18 17:01:52"
/// updated_at : "2022-10-18 17:01:52"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? amount, 
      String? upiId, 
      String? bankName, 
      String? accountNumber, 
      String? ifscCode, 
      String? accountHolderName, 
      String? isApproved, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _amount = amount;
    _upiId = upiId;
    _bankName = bankName;
    _accountNumber = accountNumber;
    _ifscCode = ifscCode;
    _accountHolderName = accountHolderName;
    _isApproved = isApproved;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _amount = json['amount'];
    _upiId = json['upi_id'];
    _bankName = json['bank_name'];
    _accountNumber = json['account_number'];
    _ifscCode = json['ifsc_code'];
    _accountHolderName = json['account_holder_name'];
    _isApproved = json['is_approved'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _amount;
  String? _upiId;
  String? _bankName;
  String? _accountNumber;
  String? _ifscCode;
  String? _accountHolderName;
  String? _isApproved;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? userId,
  String? amount,
  String? upiId,
  String? bankName,
  String? accountNumber,
  String? ifscCode,
  String? accountHolderName,
  String? isApproved,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  amount: amount ?? _amount,
  upiId: upiId ?? _upiId,
  bankName: bankName ?? _bankName,
  accountNumber: accountNumber ?? _accountNumber,
  ifscCode: ifscCode ?? _ifscCode,
  accountHolderName: accountHolderName ?? _accountHolderName,
  isApproved: isApproved ?? _isApproved,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get upiId => _upiId;
  String? get bankName => _bankName;
  String? get accountNumber => _accountNumber;
  String? get ifscCode => _ifscCode;
  String? get accountHolderName => _accountHolderName;
  String? get isApproved => _isApproved;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['upi_id'] = _upiId;
    map['bank_name'] = _bankName;
    map['account_number'] = _accountNumber;
    map['ifsc_code'] = _ifscCode;
    map['account_holder_name'] = _accountHolderName;
    map['is_approved'] = _isApproved;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}