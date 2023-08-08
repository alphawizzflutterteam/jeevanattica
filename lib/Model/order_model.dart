class OrderModel {
  String? id;
  String? userId;
  String? addressId;
  String? mobile;
  String? total;
  String? deliveryCharge;
  String? isDeliveryChargeReturnable;
  String? walletBalance;
  String? promoCode;
  String? promoDiscount;
  String? discount;
  String? totalPayable;
  String? finalTotal;
  String? paymentMethod;
  String? latitude;
  String? longitude;
  String? address;
  String? deliveryTime;
  String? deliveryDate;
  String? dateAdded;
  String? otp;
  String? notes;
  String? username;
  String? countryCode;
  String? name;
  List<String>? attachments;
  String? courierAgency;
  String? trackingId;
  String? url;
  String? isReturnable;
  String? isCancelable;
  String? isAlreadyReturned;
  String? isAlreadyCancelled;
  String? returnRequestSubmitted;
  String? totalTaxPercent;
  String? totalTaxAmount;
  List<OrderItems>? orderItems;

  OrderModel({this.id, this.userId, this.addressId, this.mobile, this.total, this.deliveryCharge, this.isDeliveryChargeReturnable, this.walletBalance, this.promoCode, this.promoDiscount, this.discount, this.totalPayable, this.finalTotal, this.paymentMethod, this.latitude, this.longitude, this.address, this.deliveryTime, this.deliveryDate, this.dateAdded, this.otp, this.notes, this.username, this.countryCode, this.name, this.attachments, this.courierAgency, this.trackingId, this.url, this.isReturnable, this.isCancelable, this.isAlreadyReturned, this.isAlreadyCancelled, this.returnRequestSubmitted, this.totalTaxPercent, this.totalTaxAmount, this.orderItems});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressId = json['address_id'];
    mobile = json['mobile'];
    total = json['total'];
    deliveryCharge = json['delivery_charge'];
    isDeliveryChargeReturnable = json['is_delivery_charge_returnable'];
    walletBalance = json['wallet_balance'];
    promoCode = json['promo_code'];
    promoDiscount = json['promo_discount'];
    discount = json['discount'];
    totalPayable = json['total_payable'];
    finalTotal = json['final_total'];
    paymentMethod = json['payment_method'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    deliveryTime = json['delivery_time'];
    deliveryDate = json['delivery_date'];
    dateAdded = json['date_added'];
    otp = json['otp'];
    notes = json['notes'];
    username = json['username'];
    countryCode = json['country_code'];
    name = json['name'];
    if (json['attachments'] != []) {
      attachments =[];
      json['attachments'].forEach((v) { attachments!.add(v); });
    }
    courierAgency = json['courier_agency'];
    trackingId = json['tracking_id'];
    url = json['url'];
    isReturnable = json['is_returnable'];
    isCancelable = json['is_cancelable'];
    isAlreadyReturned = json['is_already_returned'];
    isAlreadyCancelled = json['is_already_cancelled'];
    returnRequestSubmitted = json['return_request_submitted'];
    totalTaxPercent = json['total_tax_percent'];
    totalTaxAmount = json['total_tax_amount'];
    if (json['order_items'] != String) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) { orderItems!.add(new OrderItems.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address_id'] = this.addressId;
    data['mobile'] = this.mobile;
    data['total'] = this.total;
    data['delivery_charge'] = this.deliveryCharge;
    data['is_delivery_charge_returnable'] = this.isDeliveryChargeReturnable;
    data['wallet_balance'] = this.walletBalance;
    data['promo_code'] = this.promoCode;
    data['promo_discount'] = this.promoDiscount;
    data['discount'] = this.discount;
    data['total_payable'] = this.totalPayable;
    data['final_total'] = this.finalTotal;
    data['payment_method'] = this.paymentMethod;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['delivery_time'] = this.deliveryTime;
    data['delivery_date'] = this.deliveryDate;
    data['date_added'] = this.dateAdded;
    data['otp'] = this.otp;
    data['notes'] = this.notes;
    data['username'] = this.username;
    data['country_code'] = this.countryCode;
    data['name'] = this.name;
    if (this.attachments != []) {
      data['attachments'] = this.attachments!.map((v) => v).toList();
    }
    data['courier_agency'] = this.courierAgency;
    data['tracking_id'] = this.trackingId;
    data['url'] = this.url;
    data['is_returnable'] = this.isReturnable;
    data['is_cancelable'] = this.isCancelable;
    data['is_already_returned'] = this.isAlreadyReturned;
    data['is_already_cancelled'] = this.isAlreadyCancelled;
    data['return_request_submitted'] = this.returnRequestSubmitted;
    data['total_tax_percent'] = this.totalTaxPercent;
    data['total_tax_amount'] = this.totalTaxAmount;
    if (this.orderItems != String) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItems {
  String? id;
  String? userId;
  String? orderId;
  String? deliveryBoyId;
  String? sellerId;
  String? isCredited;
  String? otp;
  String? productName;
  String? variantName;
  String? productVariantId;
  String? quantity;
  String? price;
  String? discountedPrice;
  String? taxPercent;
  String? taxAmount;
  String? discount;
  String? subTotal;
  String? deliverBy;
  List<List>? status;
  String? activeStatus;
  String? dateAdded;
  String? productId;
  String? isCancelable;
  String? storeName;
  String? storeDescription;
  String? sellerRating;
  String? sellerProfile;
  String? courierAgency;
  String? trackingId;
  String? url;
  String? sellerName;
  String? isReturnable;
  String? image;
  String? name;
  String? type;
  String? orderCounter;
  String? orderCancelCounter;
  String? orderReturnCounter;
  String? varaintIds;
  String? variantValues;
  String? attrName;
  String? imageSm;
  String? imageMd;
  String? isAlreadyReturned;
  String? isAlreadyCancelled;
  String? returnRequestSubmitted;

  OrderItems({this.id, this.userId, this.orderId, this.deliveryBoyId, this.sellerId, this.isCredited, this.otp, this.productName, this.variantName, this.productVariantId, this.quantity, this.price, this.discountedPrice, this.taxPercent, this.taxAmount, this.discount, this.subTotal, this.deliverBy, this.status, this.activeStatus, this.dateAdded, this.productId, this.isCancelable, this.storeName, this.storeDescription, this.sellerRating, this.sellerProfile, this.courierAgency, this.trackingId, this.url, this.sellerName, this.isReturnable, this.image, this.name, this.type, this.orderCounter, this.orderCancelCounter, this.orderReturnCounter, this.varaintIds, this.variantValues, this.attrName, this.imageSm, this.imageMd, this.isAlreadyReturned, this.isAlreadyCancelled, this.returnRequestSubmitted});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    deliveryBoyId = json['delivery_boy_id'];
    sellerId = json['seller_id'];
    isCredited = json['is_credited'];
    otp = json['otp'];
    productName = json['product_name'];
    variantName = json['variant_name'];
    productVariantId = json['product_variant_id'];
    quantity = json['quantity'];
    price = json['price'];
    discountedPrice = json['discounted_price'];
    taxPercent = json['tax_percent'];
    taxAmount = json['tax_amount'];
    discount = json['discount'];
    subTotal = json['sub_total'];
    deliverBy = json['deliver_by'];
    if (json['status'] != []) {
      status = <List>[];
      json['status'].forEach((v) { status!.add(v); });
    }
    activeStatus = json['active_status'];
    dateAdded = json['date_added'];
    productId = json['product_id'];
    isCancelable = json['is_cancelable'];
    storeName = json['store_name'];
    storeDescription = json['store_description'];
    sellerRating = json['seller_rating'];
    sellerProfile = json['seller_profile'];
    courierAgency = json['courier_agency'];
    trackingId = json['tracking_id'];
    url = json['url'];
    sellerName = json['seller_name'];
    isReturnable = json['is_returnable'];
    image = json['image'];
    name = json['name'];
    type = json['type'];
    orderCounter = json['order_counter'];
    orderCancelCounter = json['order_cancel_counter'];
    orderReturnCounter = json['order_return_counter'];
    varaintIds = json['varaint_ids'];
    variantValues = json['variant_values'];
    attrName = json['attr_name'];
    imageSm = json['image_sm'];
    imageMd = json['image_md'];
    isAlreadyReturned = json['is_already_returned'];
    isAlreadyCancelled = json['is_already_cancelled'];
    returnRequestSubmitted = json['return_request_submitted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['seller_id'] = this.sellerId;
    data['is_credited'] = this.isCredited;
    data['otp'] = this.otp;
    data['product_name'] = this.productName;
    data['variant_name'] = this.variantName;
    data['product_variant_id'] = this.productVariantId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discounted_price'] = this.discountedPrice;
    data['tax_percent'] = this.taxPercent;
    data['tax_amount'] = this.taxAmount;
    data['discount'] = this.discount;
    data['sub_total'] = this.subTotal;
    data['deliver_by'] = this.deliverBy;
    if (this.status != []) {
      data['status'] = this.status!.map((v) => v).toList();
    }
    data['active_status'] = this.activeStatus;
    data['date_added'] = this.dateAdded;
    data['product_id'] = this.productId;
    data['is_cancelable'] = this.isCancelable;
    data['store_name'] = this.storeName;
    data['store_description'] = this.storeDescription;
    data['seller_rating'] = this.sellerRating;
    data['seller_profile'] = this.sellerProfile;
    data['courier_agency'] = this.courierAgency;
    data['tracking_id'] = this.trackingId;
    data['url'] = this.url;
    data['seller_name'] = this.sellerName;
    data['is_returnable'] = this.isReturnable;
    data['image'] = this.image;
    data['name'] = this.name;
    data['type'] = this.type;
    data['order_counter'] = this.orderCounter;
    data['order_cancel_counter'] = this.orderCancelCounter;
    data['order_return_counter'] = this.orderReturnCounter;
    data['varaint_ids'] = this.varaintIds;
    data['variant_values'] = this.variantValues;
    data['attr_name'] = this.attrName;
    data['image_sm'] = this.imageSm;
    data['image_md'] = this.imageMd;
    data['is_already_returned'] = this.isAlreadyReturned;
    data['is_already_cancelled'] = this.isAlreadyCancelled;
    data['return_request_submitted'] = this.returnRequestSubmitted;
    return data;
  }
}


