class CityModel {
  String? id;
  String? name;
  bool? check;
  CityModel({this.id, this.name,this.check});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    check = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
class AreaModel {
  String? id;
  String? name;
  String? cityId;
  String? zipcodeId;
  String? minimumFreeDeliveryOrderAmount;
  String? deliveryCharges;
  String? pincode;
  bool? check;
  AreaModel(
      {this.id,
        this.name,
        this.cityId,
        this.zipcodeId,
        this.minimumFreeDeliveryOrderAmount,
        this.deliveryCharges,
        this.pincode,this.check});

  AreaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cityId = json['city_id'];
    zipcodeId = json['zipcode_id'];
    minimumFreeDeliveryOrderAmount = json['minimum_free_delivery_order_amount'];
    deliveryCharges = json['delivery_charges'];
    pincode = json['pincode'];
    check = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city_id'] = this.cityId;
    data['zipcode_id'] = this.zipcodeId;
    data['minimum_free_delivery_order_amount'] =
        this.minimumFreeDeliveryOrderAmount;
    data['delivery_charges'] = this.deliveryCharges;
    data['pincode'] = this.pincode;
    return data;
  }
}

class AddModel {
  String? id;
  String? userId;
  String? name;
  String? type;
  String? mobile;
  String? alternateMobile;
  String? address;
  String? landmark;
  String? areaId;
  String? cityId;
  String? pincode;
  String? countryCode;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  String? isDefault;

  AddModel(
      {this.id,
        this.userId,
        this.name,
        this.type,
        this.mobile,
        this.alternateMobile,
        this.address,
        this.landmark,
        this.areaId,
        this.cityId,
        this.pincode,
        this.countryCode,
        this.state,
        this.country,
        this.latitude,
        this.longitude,
        this.isDefault});

  AddModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    type = json['type'];
    mobile = json['mobile'];
    alternateMobile = json['alternate_mobile'];
    address = json['address'];
    landmark = json['landmark'];
    areaId = json['area_id'];
    cityId = json['city_id'];
    pincode = json['pincode'];
    countryCode = json['country_code'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['mobile'] = this.mobile;
    data['alternate_mobile'] = this.alternateMobile;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['area_id'] = this.areaId;
    data['city_id'] = this.cityId;
    data['pincode'] = this.pincode;
    data['country_code'] = this.countryCode;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_default'] = this.isDefault;
    return data;
  }
}
