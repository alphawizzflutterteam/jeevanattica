class ProductRatingModel {
  ProductRatingModel({
      bool? error, 
      String? message, 
      num? noOfRating, 
      String? total, 
      String? star1, 
      String? star2, 
      String? star3, 
      String? star4, 
      String? star5, 
      dynamic totalImages, 
      String? productRating, 
      List<RatingData>? dataRating,}){
    _error = error;
    _message = message;
    _noOfRating = noOfRating;
    _total = total;
    _star1 = star1;
    _star2 = star2;
    _star3 = star3;
    _star4 = star4;
    _star5 = star5;
    _totalImages = totalImages;
    _productRating = productRating;
    _dataRating = dataRating;
}

  ProductRatingModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _noOfRating = json['no_of_rating'];
    _total = json['total'];
    _star1 = json['star_1'];
    _star2 = json['star_2'];
    _star3 = json['star_3'];
    _star4 = json['star_4'];
    _star5 = json['star_5'];
    _totalImages = json['total_images'];
    _productRating = json['product_rating'];
    if (json['rating_data'] != null) {
      _dataRating = [];
      json['rating_data'].forEach((v) {
        _dataRating?.add(RatingData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  num? _noOfRating;
  String? _total;
  String? _star1;
  String? _star2;
  String? _star3;
  String? _star4;
  String? _star5;
  dynamic _totalImages;
  String? _productRating;
  List<RatingData>? _dataRating;
ProductRatingModel copyWith({  bool? error,
  String? message,
  num? noOfRating,
  String? total,
  String? star1,
  String? star2,
  String? star3,
  String? star4,
  String? star5,
  dynamic totalImages,
  String? productRating,
  List<RatingData>? data,
}) => ProductRatingModel(  error: error ?? _error,
  message: message ?? _message,
  noOfRating: noOfRating ?? _noOfRating,
  total: total ?? _total,
  star1: star1 ?? _star1,
  star2: star2 ?? _star2,
  star3: star3 ?? _star3,
  star4: star4 ?? _star4,
  star5: star5 ?? _star5,
  totalImages: totalImages ?? _totalImages,
  productRating: productRating ?? _productRating,
  dataRating: data ?? _dataRating,
);
  bool? get error => _error;
  String? get message => _message;
  num? get noOfRating => _noOfRating;
  String? get total => _total;
  String? get star1 => _star1;
  String? get star2 => _star2;
  String? get star3 => _star3;
  String? get star4 => _star4;
  String? get star5 => _star5;
  dynamic get totalImages => _totalImages;
  String? get productRating => _productRating;
  List<RatingData>? get data => _dataRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['no_of_rating'] = _noOfRating;
    map['total'] = _total;
    map['star_1'] = _star1;
    map['star_2'] = _star2;
    map['star_3'] = _star3;
    map['star_4'] = _star4;
    map['star_5'] = _star5;
    map['total_images'] = _totalImages;
    map['product_rating'] = _productRating;
    if (_dataRating != null) {
      map['rating_data'] = _dataRating?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class RatingData {
  RatingData({
      String? id, 
      String? userId, 
      String? productId, 
      String? rating, 
      List<dynamic>? images, 
      String? comment, 
      String? dataAdded, 
      String? userName, 
      String? userProfile,}){
    _id = id;
    _userId = userId;
    _productId = productId;
    _rating = rating;
    _images = images;
    _comment = comment;
    _dataAdded = dataAdded;
    _userName = userName;
    _userProfile = userProfile;
}

  RatingData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _productId = json['product_id'];
    _rating = json['rating'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(v);
      });
    }
    _comment = json['comment'];
    _dataAdded = json['data_added'];
    _userName = json['user_name'];
    _userProfile = json['user_profile'];
  }
  String? _id;
  String? _userId;
  String? _productId;
  String? _rating;
  List<dynamic>? _images;
  String? _comment;
  String? _dataAdded;
  String? _userName;
  String? _userProfile;
RatingData copyWith({  String? id,
  String? userId,
  String? productId,
  String? rating,
  List<dynamic>? images,
  String? comment,
  String? dataAdded,
  String? userName,
  String? userProfile,
}) => RatingData(  id: id ?? _id,
  userId: userId ?? _userId,
  productId: productId ?? _productId,
  rating: rating ?? _rating,
  images: images ?? _images,
  comment: comment ?? _comment,
  dataAdded: dataAdded ?? _dataAdded,
  userName: userName ?? _userName,
  userProfile: userProfile ?? _userProfile,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get productId => _productId;
  String? get rating => _rating;
  List<dynamic>? get images => _images;
  String? get comment => _comment;
  String? get dataAdded => _dataAdded;
  String? get userName => _userName;
  String? get userProfile => _userProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['product_id'] = _productId;
    map['rating'] = _rating;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['comment'] = _comment;
    map['data_added'] = _dataAdded;
    map['user_name'] = _userName;
    map['user_profile'] = _userProfile;
    return map;
  }

}