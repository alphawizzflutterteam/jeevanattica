import 'dart:convert';
/// error : false
/// message : "Transactions Retrieved Successfully"
/// total : "10"
/// balance : "0"
/// data : [{"id":"76","type":"1","user_id":"2","order_id":"0","credit":"1","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-03 10:45:14","purchase_type":"buy"},{"id":"74","type":"1","user_id":"2","order_id":"0","credit":"1","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-02 18:23:59","purchase_type":"buy"},{"id":"66","type":"1","user_id":"2","order_id":"0","credit":"2","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-02 18:14:31","purchase_type":"buy"},{"id":"65","type":"1","user_id":"2","order_id":"0","credit":"2","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-02 18:14:24","purchase_type":"buy"},{"id":"64","type":"1","user_id":"2","order_id":"0","credit":"1","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-02 18:14:15","purchase_type":"buy"},{"id":"47","type":"1","user_id":"2","order_id":"0","credit":"1","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-02 16:50:30","purchase_type":"buy"},{"id":"46","type":"1","user_id":"2","order_id":"0","credit":"1","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-02 16:24:47","purchase_type":"buy"},{"id":"45","type":"1","user_id":"2","order_id":"0","credit":"1","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-02 16:23:54","purchase_type":"buy"},{"id":"44","type":"1","user_id":"2","order_id":"0","credit":"1","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-02 16:22:06","purchase_type":"buy"},{"id":"42","type":"1","user_id":"2","order_id":"0","credit":"1","debit":"","total":"","amount":"100","debit_amount":"","total_amount":"","payment_status":"success","rzp_order_id":"1","rzp_sign_id":"","rzp_txn_id":"","tax":"","status":"","created_At":"2022-08-02 15:47:01","purchase_type":"buy"}]

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));
String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());
class TransactionModel {
  TransactionModel({
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

  TransactionModel.fromJson(dynamic json) {
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
TransactionModel copyWith({  bool? error,
  String? message,
  String? total,
  String? balance,
  List<Data>? data,
}) => TransactionModel(  error: error ?? _error,
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

/// id : "76"
/// type : "1"
/// user_id : "2"
/// order_id : "0"
/// credit : "1"
/// debit : ""
/// total : ""
/// amount : "100"
/// debit_amount : ""
/// total_amount : ""
/// payment_status : "success"
/// rzp_order_id : "1"
/// rzp_sign_id : ""
/// rzp_txn_id : ""
/// tax : ""
/// status : ""
/// created_At : "2022-08-03 10:45:14"
/// purchase_type : "buy"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    String? id, ptype,
      String? type, 
      String? userId, 
      String? orderId, 
      String? credit, 
      String? debit, 
      String? total, 
      String? amount, 
      String? debitAmount, 
      String? totalAmount, 
      String? paymentStatus, 
      String? rzpOrderId, 
      String? rzpSignId, 
      String? rzpTxnId, 
      String? tax, 
      String? status, 
      String? createdAt, 
      String? purchaseType,}){
    _id = id;
    _type = type;
    _userId = userId;
    _orderId = orderId;
    _credit = credit;
    _debit = debit;
    _ptype = ptype;

    _total = total;
    _amount = amount;
    _debitAmount = debitAmount;
    _totalAmount = totalAmount;
    _paymentStatus = paymentStatus;
    _rzpOrderId = rzpOrderId;
    _rzpSignId = rzpSignId;
    _rzpTxnId = rzpTxnId;
    _tax = tax;
    _status = status;
    _createdAt = createdAt;
    _purchaseType = purchaseType;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _userId = json['user_id'];
    _orderId = json['order_id'];
    _credit = json['credit'];
    _debit = json['debit'];
    _total = json['total'];
    _amount = json['amount'];
    _debitAmount = json['debit_amount'];
    _totalAmount = json['total_amount'];
    _paymentStatus = json['payment_status'];
    _rzpOrderId = json['rzp_order_id'];
    _rzpSignId = json['rzp_sign_id'];
    _rzpTxnId = json['rzp_txn_id'];
    _tax = json['tax'];
    _status = json['status'];
    _createdAt = json['created_At'];
    _purchaseType = json['purchase_type'];
    _ptype = json['ptype'];
  }
  String? _id, _ptype;
  String? _type;
  String? _userId;
  String? _orderId;
  String? _credit;
  String? _debit;
  String? _total;
  String? _amount;
  String? _debitAmount;
  String? _totalAmount;
  String? _paymentStatus;
  String? _rzpOrderId;
  String? _rzpSignId;
  String? _rzpTxnId;
  String? _tax;
  String? _status;
  String? _createdAt;
  String? _purchaseType;
Data copyWith({  String? id,
  String? type, ptype,
  String? userId,
  String? orderId,
  String? credit,
  String? debit,
  String? total,
  String? amount,
  String? debitAmount,
  String? totalAmount,
  String? paymentStatus,
  String? rzpOrderId,
  String? rzpSignId,
  String? rzpTxnId,
  String? tax,
  String? status,
  String? createdAt,
  String? purchaseType,
}) => Data(  id: id ?? _id,
  type: type ?? _type,
  userId: userId ?? _userId,
  orderId: orderId ?? _orderId,
  credit: credit ?? _credit,
  debit: debit ?? _debit,
  total: total ?? _total,
  amount: amount ?? _amount,
  debitAmount: debitAmount ?? _debitAmount,
  totalAmount: totalAmount ?? _totalAmount,
  paymentStatus: paymentStatus ?? _paymentStatus,
  rzpOrderId: rzpOrderId ?? _rzpOrderId,
  rzpSignId: rzpSignId ?? _rzpSignId,
  rzpTxnId: rzpTxnId ?? _rzpTxnId,
  tax: tax ?? _tax,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  purchaseType: purchaseType ?? _purchaseType,
  ptype: ptype ?? _ptype,

);
  String? get id => _id;
  String? get ptype => _ptype;

  String? get type => _type;
  String? get userId => _userId;
  String? get orderId => _orderId;
  String? get credit => _credit;
  String? get debit => _debit;
  String? get total => _total;
  String? get amount => _amount;
  String? get debitAmount => _debitAmount;
  String? get totalAmount => _totalAmount;
  String? get paymentStatus => _paymentStatus;
  String? get rzpOrderId => _rzpOrderId;
  String? get rzpSignId => _rzpSignId;
  String? get rzpTxnId => _rzpTxnId;
  String? get tax => _tax;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get purchaseType => _purchaseType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['user_id'] = _userId;
    map['order_id'] = _orderId;
    map['credit'] = _credit;
    map['debit'] = _debit;
    map['total'] = _total;
    map['amount'] = _amount;
    map['debit_amount'] = _debitAmount;
    map['total_amount'] = _totalAmount;
    map['payment_status'] = _paymentStatus;
    map['rzp_order_id'] = _rzpOrderId;
    map['rzp_sign_id'] = _rzpSignId;
    map['rzp_txn_id'] = _rzpTxnId;
    map['tax'] = _tax;
    map['status'] = _status;
    map['created_At'] = _createdAt;
    map['purchase_type'] = _purchaseType;
    map['ptype'] = _ptype;
    return map;
  }

}