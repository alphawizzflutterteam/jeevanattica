/// am_rate : "5141.61"
/// am_rate985 : 5090.19
/// am_rate916 : 5038.78
/// am_rate995 : 5193.03
/// am_rate750 : 4216.12
/// am_rate999 : 5244.44
/// am_rate999.99 : 63.34

class LivePriceModel {
  LivePriceModel({
      String? amRate, 
      num? amRate985, 
      num? amRate916, 
      num? amRate995, 
      num? amRate750, 
      num? amRate999, 
      num? amRate99999,}){
    _amRate = amRate;
    _amRate985 = amRate985;
    _amRate916 = amRate916;
    _amRate995 = amRate995;
    _amRate750 = amRate750;
    _amRate999 = amRate999;
    _amRate99999 = amRate99999;
}

  LivePriceModel.fromJson(dynamic json) {
    _amRate = json['am_rate'];
    _amRate985 = json['am_rate985'];
    _amRate916 = json['am_rate916'];
    _amRate995 = json['am_rate995'];
    _amRate750 = json['am_rate750'];
    _amRate999 = json['am_rate999'];
    _amRate99999 = json['am_rate999.99'];
  }
  String? _amRate;
  num? _amRate985;
  num? _amRate916;
  num? _amRate995;
  num? _amRate750;
  num? _amRate999;
  num? _amRate99999;
LivePriceModel copyWith({  String? amRate,
  num? amRate985,
  num? amRate916,
  num? amRate995,
  num? amRate750,
  num? amRate999,
  num? amRate99999,
}) => LivePriceModel(  amRate: amRate ?? _amRate,
  amRate985: amRate985 ?? _amRate985,
  amRate916: amRate916 ?? _amRate916,
  amRate995: amRate995 ?? _amRate995,
  amRate750: amRate750 ?? _amRate750,
  amRate999: amRate999 ?? _amRate999,
  amRate99999: amRate99999 ?? _amRate99999,
);
  String? get amRate => _amRate;
  num? get amRate985 => _amRate985;
  num? get amRate916 => _amRate916;
  num? get amRate995 => _amRate995;
  num? get amRate750 => _amRate750;
  num? get amRate999 => _amRate999;
  num? get amRate99999 => _amRate99999;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['am_rate'] = _amRate;
    map['am_rate985'] = _amRate985;
    map['am_rate916'] = _amRate916;
    map['am_rate995'] = _amRate995;
    map['am_rate750'] = _amRate750;
    map['am_rate999'] = _amRate999;
    map['am_rate999.99'] = _amRate99999;
    return map;
  }

}