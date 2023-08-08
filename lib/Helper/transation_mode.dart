import 'dart:convert';
/// error : false
/// message : "Transactions Retrieved Successfully"
/// total : "2"
/// balance : "0"
/// data : [{"id":"3","transaction_type":"transaction","user_id":"20","order_id":"","type":"delivery_boy_cash_collection","txn_id":"","payu_txn_id":null,"amount":"170","status":"1","currency_code":null,"payer_email":null,"message":"Delivery boy cash collection by admin","transaction_date":"2022-01-20 10:27:48","date_created":"2022-01-20 10:27:48"},{"id":"2","transaction_type":"transaction","user_id":"20","order_id":"7","type":"delivery_boy_cash","txn_id":"","payu_txn_id":null,"amount":"170","status":"1","currency_code":null,"payer_email":null,"message":"Delivery boy collected COD","transaction_date":"2022-01-12 19:27:04","date_created":"2022-01-12 19:27:04"}]

TransationModeOnlyAmount transationModeFromJson(String str) => TransationModeOnlyAmount.fromJson(json.decode(str));
String transationModeToJson(TransationModeOnlyAmount data) => json.encode(data.toJson());
class TransationModeOnlyAmount {
  TransationModeOnlyAmount({
      bool? error, 
      String? message, 
      String? total, 
      String? balance, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _total = total;
    _balance = balance;
    _data = data;
}

  TransationModeOnlyAmount.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _total = json['total'];
    _balance = json['balance'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  String? _total;
  String? _balance;
  List<Data>? _data;
TransationModeOnlyAmount copyWith({  bool? error,
  String? message,
  String? total,
  String? balance,
  List<Data>? data,
}) => TransationModeOnlyAmount(  error: error ?? _error,
  message: message ?? _message,
  total: total ?? _total,
  balance: balance ?? _balance,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  String? get total => _total;
  String? get balance => _balance;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['total'] = _total;
    map['balance'] = _balance;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// transaction_type : "transaction"
/// user_id : "20"
/// order_id : ""
/// type : "delivery_boy_cash_collection"
/// txn_id : ""
/// payu_txn_id : null
/// amount : "170"
/// status : "1"
/// currency_code : null
/// payer_email : null
/// message : "Delivery boy cash collection by admin"
/// transaction_date : "2022-01-20 10:27:48"
/// date_created : "2022-01-20 10:27:48"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, credit, ptype,
      String? transactionType, 
      String? userId, 
      String? orderId, 
      String? type, 
      String? txnId, 
      dynamic payuTxnId, 
      String? amount, 
      String? status, 
      dynamic currencyCode, 
      dynamic payerEmail, 
      String? message, 
      String? transactionDate, 
      String? dateCreated,}){
    _id = id;
    _transactionType = transactionType;
    _userId = userId;
    _orderId = orderId;
    _type = type;
    _txnId = txnId;
    _payuTxnId = payuTxnId;
    _amount = amount;
    _status = status;
    _currencyCode = currencyCode;
    _payerEmail = payerEmail;
    _message = message;
    _transactionDate = transactionDate;
    _dateCreated = dateCreated;
    _credit = credit;
    _ptype = ptype;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _transactionType = json['transaction_type'];
    _userId = json['user_id'];
    _orderId = json['order_id'];
    _type = json['type'];
    _txnId = json['txn_id'];
    _payuTxnId = json['payu_txn_id'];
    _amount = json['amount'];
    _status = json['status'];
    _currencyCode = json['currency_code'];
    _payerEmail = json['payer_email'];
    _message = json['message'];
    _transactionDate = json['transaction_date'];
    _dateCreated = json['date_created'];
    _credit = json['credit'];
    _ptype = json['ptype'];

  }
  String? _id , _ptype,_credit;
  String? _transactionType;
  String? _userId;
  String? _orderId;
  String? _type;
  String? _txnId;
  dynamic _payuTxnId;
  String? _amount;
  String? _status;
  dynamic _currencyCode;
  dynamic _payerEmail;
  String? _message;
  String? _transactionDate;
  String? _dateCreated;
Data copyWith({  String? id,
  String? transactionType,
  String? userId,
  String? ptype,
  String? credit,
  String? orderId,
  String? type,
  String? txnId,
  dynamic payuTxnId,
  String? amount,
  String? status,
  dynamic currencyCode,
  dynamic payerEmail,
  String? message,
  String? transactionDate,
  String? dateCreated,
}) => Data(  id: id ?? _id,
  transactionType: transactionType ?? _transactionType,
  userId: userId ?? _userId,
  orderId: orderId ?? _orderId,
  type: type ?? _type,
  txnId: txnId ?? _txnId,
  payuTxnId: payuTxnId ?? _payuTxnId,
  amount: amount ?? _amount,
  status: status ?? _status,
  currencyCode: currencyCode ?? _currencyCode,
  payerEmail: payerEmail ?? _payerEmail,
  message: message ?? _message,
  transactionDate: transactionDate ?? _transactionDate,
  dateCreated: dateCreated ?? _dateCreated,
  ptype: ptype ?? _ptype,
  credit: credit ?? _credit,
);
  String? get id => _id;
  String? get ptype => _ptype;
  String? get credit => _credit;
  String? get transactionType => _transactionType;
  String? get userId => _userId;
  String? get orderId => _orderId;
  String? get type => _type;
  String? get txnId => _txnId;
  dynamic get payuTxnId => _payuTxnId;
  String? get amount => _amount;
  String? get status => _status;
  dynamic get currencyCode => _currencyCode;
  dynamic get payerEmail => _payerEmail;
  String? get message => _message;
  String? get transactionDate => _transactionDate;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ptype'] = _ptype;
    map['credit'] = _credit;
    map['transaction_type'] = _transactionType;
    map['user_id'] = _userId;
    map['order_id'] = _orderId;
    map['type'] = _type;
    map['txn_id'] = _txnId;
    map['payu_txn_id'] = _payuTxnId;
    map['amount'] = _amount;
    map['status'] = _status;
    map['currency_code'] = _currencyCode;
    map['payer_email'] = _payerEmail;
    map['message'] = _message;
    map['transaction_date'] = _transactionDate;
    map['date_created'] = _dateCreated;
    return map;
  }

}