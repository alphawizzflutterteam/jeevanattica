class SubCategoryModel {
  SubCategoryModel({
      this.error, 
      this.message, 
      this.minPrice, 
      this.maxPrice, 
      this.search, 
      this.filters, 
      this.tags, 
      this.total, 
      this.offset, 
      this.product,});

  SubCategoryModel.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    search = json['search'];
    if (json['filters'] != null) {
      filters = [];
      json['filters'].forEach((v) {
        filters?.add(v);
      });
    }
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(v);
      });
    }
    total = json['total'];
    offset = json['offset'];
    if (json['product'] != null) {
      product = [];
      json['product'].forEach((v) {
        product?.add(ProductModel.fromJson(v));
      });
    }
  }
  bool? error;
  String? message;
  String? minPrice;
  String? maxPrice;
  dynamic search;
  List<dynamic>? filters;
  List<dynamic>? tags;
  String? total;
  String? offset;
  List<dynamic>? product;
SubCategoryModel copyWith({  bool? error,
  String? message,
  String? minPrice,
  String? maxPrice,
  dynamic search,
  List<dynamic>? filters,
  List<dynamic>? tags,
  String? total,
  String? offset,
  List<dynamic>? product,
}) => SubCategoryModel(  error: error ?? this.error,
  message: message ?? this.message,
  minPrice: minPrice ?? this.minPrice,
  maxPrice: maxPrice ?? this.maxPrice,
  search: search ?? this.search,
  filters: filters ?? this.filters,
  tags: tags ?? this.tags,
  total: total ?? this.total,
  offset: offset ?? this.offset,
  product: product ?? this.product,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    map['min_price'] = minPrice;
    map['max_price'] = maxPrice;
    map['search'] = search;
    if (filters != null) {
      map['filters'] = filters?.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['offset'] = offset;
    if (product != null) {
      map['product'] = product?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ProductModel {
  ProductModel({
      this.total, 
      this.sales, 
      this.stockType, 
      this.isPricesInclusiveTax, 
      this.type, 
      this.attrValueIds, 
      this.sellerRating, 
      this.sellerSlug, 
      this.sellerNoOfRatings, 
      this.sellerProfile, 
      this.storeName, 
      this.storeDescription, 
      this.sellerId, 
      this.sellerName, 
      this.id, 
      this.stock, 
      this.name, 
      this.categoryId, 
      this.subCategoryId, 
      this.shortDescription, 
      this.price, 
      this.weight, 
      this.slug, 
      this.description, 
      this.totalAllowedQuantity, 
      this.deliverableType, 
      this.deliverableZipcodes, 
      this.minimumOrderQuantity, 
      this.quantityStepSize, 
      this.codAllowed, 
      this.rowOrder, 
      this.rating, 
      this.noOfRatings, 
      this.image, 
      this.isReturnable, 
      this.isCancelable, 
      this.cancelableTill, 
      this.indicator, 
      this.otherImages, 
      this.videoType, 
      this.video, 
      this.tags, 
      this.warrantyPeriod, 
      this.guaranteePeriod, 
      this.madeIn, 
      this.availability, 
      this.categoryName, 
      this.taxPercentage, 
      this.reviewImages, 
      this.attributes, 
      this.variants, 
      this.minMaxPrice, 
      this.deliverableZipcodesIds, 
      this.isDeliverable, 
      this.isPurchased, 
      this.isFavorite, 
      this.imageMd, 
      this.imageSm, 
      this.otherImagesSm, 
      this.otherImagesMd, 
      this.variantAttributes,});

  ProductModel.fromJson(dynamic json) {
    total = json['total'];
    sales = json['sales'];
    stockType = json['stock_type'];
    isPricesInclusiveTax = json['is_prices_inclusive_tax'];
    type = json['type'];
    attrValueIds = json['attr_value_ids'];
    sellerRating = json['seller_rating'];
    sellerSlug = json['seller_slug'];
    sellerNoOfRatings = json['seller_no_of_ratings'];
    sellerProfile = json['seller_profile'];
    storeName = json['store_name'];
    storeDescription = json['store_description'];
    sellerId = json['seller_id'];
    sellerName = json['seller_name'];
    id = json['id'];
    stock = json['stock'];
    name = json['name'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    shortDescription = json['short_description'];
    price = json['price'];
    weight = json['weight'];
    slug = json['slug'];
    description = json['description'];
    totalAllowedQuantity = json['total_allowed_quantity'];
    deliverableType = json['deliverable_type'];
    deliverableZipcodes = json['deliverable_zipcodes'];
    minimumOrderQuantity = json['minimum_order_quantity'];
    quantityStepSize = json['quantity_step_size'];
    codAllowed = json['cod_allowed'];
    rowOrder = json['row_order'];
    rating = json['rating'];
    noOfRatings = json['no_of_ratings'];
    image = json['image'];
    isReturnable = json['is_returnable'];
    isCancelable = json['is_cancelable'];
    cancelableTill = json['cancelable_till'];
    indicator = json['indicator'];
    if (json['other_images'] != null) {
      otherImages = [];
      json['other_images'].forEach((v) {
        otherImages?.add((v));
      });
    }
    videoType = json['video_type'];
    video = json['video'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add((v));
      });
    }
    warrantyPeriod = json['warranty_period'];
    guaranteePeriod = json['guarantee_period'];
    madeIn = json['made_in'];
    availability = json['availability'];
    categoryName = json['category_name'];
    taxPercentage = json['tax_percentage'];
    if (json['review_images'] != null) {
      reviewImages = [];
      json['review_images'].forEach((v) {
        reviewImages?.add((v));
      });
    }
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes?.add((v));
      });
    }
    if (json['variants'] != null) {
      variants = [];
      json['variants'].forEach((v) {
        variants?.add(Variants.fromJson(v));
      });
    }
    minMaxPrice = json['min_max_price'] != null ? MinMaxPrice.fromJson(json['min_max_price']) : null;
    deliverableZipcodesIds = json['deliverable_zipcodes_ids'];
    isDeliverable = json['is_deliverable'];
    isPurchased = json['is_purchased'];
    isFavorite = json['is_favorite'];
    imageMd = json['image_md'];
    imageSm = json['image_sm'];
    if (json['other_images_sm'] != null) {
      otherImagesSm = [];
      json['other_images_sm'].forEach((v) {
        otherImagesSm?.add((v));
      });
    }
    if (json['other_images_md'] != null) {
      otherImagesMd = [];
      json['other_images_md'].forEach((v) {
        otherImagesMd?.add((v));
      });
    }
    if (json['variant_attributes'] != null) {
      variantAttributes = [];
      json['variant_attributes'].forEach((v) {
        variantAttributes?.add((v));
      });
    }
  }
  String? total;
  String? sales;
  dynamic stockType;
  String? isPricesInclusiveTax;
  String? type;
  String? attrValueIds;
  String? sellerRating;
  String? sellerSlug;
  String? sellerNoOfRatings;
  String? sellerProfile;
  String? storeName;
  String? storeDescription;
  String? sellerId;
  String? sellerName;
  String? id;
  dynamic stock;
  String? name;
  String? categoryId;
  String? subCategoryId;
  String? shortDescription;
  String? price;
  String? weight;
  String? slug;
  String? description;
  dynamic totalAllowedQuantity;
  String? deliverableType;
  dynamic deliverableZipcodes;
  String? minimumOrderQuantity;
  String? quantityStepSize;
  String? codAllowed;
  String? rowOrder;
  String? rating;
  String? noOfRatings;
  String? image;
  String? isReturnable;
  String? isCancelable;
  String? cancelableTill;
  String? indicator;
  List<dynamic>? otherImages;
  String? videoType;
  String? video;
  List<dynamic>? tags;
  String? warrantyPeriod;
  String? guaranteePeriod;
  dynamic madeIn;
  dynamic availability;
  String? categoryName;
  String? taxPercentage;
  List<dynamic>? reviewImages;
  List<dynamic>? attributes;
  List<Variants>? variants;
  MinMaxPrice? minMaxPrice;
  dynamic deliverableZipcodesIds;
  bool? isDeliverable;
  bool? isPurchased;
  num? isFavorite;
  String? imageMd;
  String? imageSm;
  List<dynamic>? otherImagesSm;
  List<dynamic>? otherImagesMd;
  List<dynamic>? variantAttributes;
ProductModel copyWith({  String? total,
  String? sales,
  dynamic stockType,
  String? isPricesInclusiveTax,
  String? type,
  String? attrValueIds,
  String? sellerRating,
  String? sellerSlug,
  String? sellerNoOfRatings,
  String? sellerProfile,
  String? storeName,
  String? storeDescription,
  String? sellerId,
  String? sellerName,
  String? id,
  dynamic stock,
  String? name,
  String? categoryId,
  String? subCategoryId,
  String? shortDescription,
  String? price,
  String? weight,
  String? slug,
  String? description,
  dynamic totalAllowedQuantity,
  String? deliverableType,
  dynamic deliverableZipcodes,
  String? minimumOrderQuantity,
  String? quantityStepSize,
  String? codAllowed,
  String? rowOrder,
  String? rating,
  String? noOfRatings,
  String? image,
  String? isReturnable,
  String? isCancelable,
  String? cancelableTill,
  String? indicator,
  List<dynamic>? otherImages,
  String? videoType,
  String? video,
  List<dynamic>? tags,
  String? warrantyPeriod,
  String? guaranteePeriod,
  dynamic madeIn,
  dynamic availability,
  String? categoryName,
  String? taxPercentage,
  List<dynamic>? reviewImages,
  List<dynamic>? attributes,
  List<Variants>? variants,
  MinMaxPrice? minMaxPrice,
  dynamic deliverableZipcodesIds,
  bool? isDeliverable,
  bool? isPurchased,
  num? isFavorite,
  String? imageMd,
  String? imageSm,
  List<dynamic>? otherImagesSm,
  List<dynamic>? otherImagesMd,
  List<dynamic>? variantAttributes,
}) => ProductModel(  total: total ?? this.total,
  sales: sales ?? this.sales,
  stockType: stockType ?? this.stockType,
  isPricesInclusiveTax: isPricesInclusiveTax ?? this.isPricesInclusiveTax,
  type: type ?? this.type,
  attrValueIds: attrValueIds ?? this.attrValueIds,
  sellerRating: sellerRating ?? this.sellerRating,
  sellerSlug: sellerSlug ?? this.sellerSlug,
  sellerNoOfRatings: sellerNoOfRatings ?? this.sellerNoOfRatings,
  sellerProfile: sellerProfile ?? this.sellerProfile,
  storeName: storeName ?? this.storeName,
  storeDescription: storeDescription ?? this.storeDescription,
  sellerId: sellerId ?? this.sellerId,
  sellerName: sellerName ?? this.sellerName,
  id: id ?? this.id,
  stock: stock ?? this.stock,
  name: name ?? this.name,
  categoryId: categoryId ?? this.categoryId,
  subCategoryId: subCategoryId ?? this.subCategoryId,
  shortDescription: shortDescription ?? this.shortDescription,
  price: price ?? this.price,
  weight: weight ?? this.weight,
  slug: slug ?? this.slug,
  description: description ?? this.description,
  totalAllowedQuantity: totalAllowedQuantity ?? this.totalAllowedQuantity,
  deliverableType: deliverableType ?? this.deliverableType,
  deliverableZipcodes: deliverableZipcodes ?? this.deliverableZipcodes,
  minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
  quantityStepSize: quantityStepSize ?? this.quantityStepSize,
  codAllowed: codAllowed ?? this.codAllowed,
  rowOrder: rowOrder ?? this.rowOrder,
  rating: rating ?? this.rating,
  noOfRatings: noOfRatings ?? this.noOfRatings,
  image: image ?? this.image,
  isReturnable: isReturnable ?? this.isReturnable,
  isCancelable: isCancelable ?? this.isCancelable,
  cancelableTill: cancelableTill ?? this.cancelableTill,
  indicator: indicator ?? this.indicator,
  otherImages: otherImages ?? this.otherImages,
  videoType: videoType ?? this.videoType,
  video: video ?? this.video,
  tags: tags ?? this.tags,
  warrantyPeriod: warrantyPeriod ?? this.warrantyPeriod,
  guaranteePeriod: guaranteePeriod ?? this.guaranteePeriod,
  madeIn: madeIn ?? this.madeIn,
  availability: availability ?? this.availability,
  categoryName: categoryName ?? this.categoryName,
  taxPercentage: taxPercentage ?? this.taxPercentage,
  reviewImages: reviewImages ?? this.reviewImages,
  attributes: attributes ?? this.attributes,
  variants: variants ?? this.variants,
  minMaxPrice: minMaxPrice ?? this.minMaxPrice,
  deliverableZipcodesIds: deliverableZipcodesIds ?? this.deliverableZipcodesIds,
  isDeliverable: isDeliverable ?? this.isDeliverable,
  isPurchased: isPurchased ?? this.isPurchased,
  isFavorite: isFavorite ?? this.isFavorite,
  imageMd: imageMd ?? this.imageMd,
  imageSm: imageSm ?? this.imageSm,
  otherImagesSm: otherImagesSm ?? this.otherImagesSm,
  otherImagesMd: otherImagesMd ?? this.otherImagesMd,
  variantAttributes: variantAttributes ?? this.variantAttributes,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['sales'] = sales;
    map['stock_type'] = stockType;
    map['is_prices_inclusive_tax'] = isPricesInclusiveTax;
    map['type'] = type;
    map['attr_value_ids'] = attrValueIds;
    map['seller_rating'] = sellerRating;
    map['seller_slug'] = sellerSlug;
    map['seller_no_of_ratings'] = sellerNoOfRatings;
    map['seller_profile'] = sellerProfile;
    map['store_name'] = storeName;
    map['store_description'] = storeDescription;
    map['seller_id'] = sellerId;
    map['seller_name'] = sellerName;
    map['id'] = id;
    map['stock'] = stock;
    map['name'] = name;
    map['category_id'] = categoryId;
    map['sub_category_id'] = subCategoryId;
    map['short_description'] = shortDescription;
    map['price'] = price;
    map['weight'] = weight;
    map['slug'] = slug;
    map['description'] = description;
    map['total_allowed_quantity'] = totalAllowedQuantity;
    map['deliverable_type'] = deliverableType;
    map['deliverable_zipcodes'] = deliverableZipcodes;
    map['minimum_order_quantity'] = minimumOrderQuantity;
    map['quantity_step_size'] = quantityStepSize;
    map['cod_allowed'] = codAllowed;
    map['row_order'] = rowOrder;
    map['rating'] = rating;
    map['no_of_ratings'] = noOfRatings;
    map['image'] = image;
    map['is_returnable'] = isReturnable;
    map['is_cancelable'] = isCancelable;
    map['cancelable_till'] = cancelableTill;
    map['indicator'] = indicator;
    if (otherImages != null) {
      map['other_images'] = otherImages?.map((v) => v.toJson()).toList();
    }
    map['video_type'] = videoType;
    map['video'] = video;
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    map['warranty_period'] = warrantyPeriod;
    map['guarantee_period'] = guaranteePeriod;
    map['made_in'] = madeIn;
    map['availability'] = availability;
    map['category_name'] = categoryName;
    map['tax_percentage'] = taxPercentage;
    if (reviewImages != null) {
      map['review_images'] = reviewImages?.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      map['attributes'] = attributes?.map((v) => v.toJson()).toList();
    }
    if (variants != null) {
      map['variants'] = variants?.map((v) => v.toJson()).toList();
    }
    if (minMaxPrice != null) {
      map['min_max_price'] = minMaxPrice?.toJson();
    }
    map['deliverable_zipcodes_ids'] = deliverableZipcodesIds;
    map['is_deliverable'] = isDeliverable;
    map['is_purchased'] = isPurchased;
    map['is_favorite'] = isFavorite;
    map['image_md'] = imageMd;
    map['image_sm'] = imageSm;
    if (otherImagesSm != null) {
      map['other_images_sm'] = otherImagesSm?.map((v) => v).toList();
    }
    if (otherImagesMd != null) {
      map['other_images_md'] = otherImagesMd?.map((v) => v).toList();
    }
    if (variantAttributes != null) {
      map['variant_attributes'] = variantAttributes?.map((v) => v).toList();
    }
    return map;
  }

}

class MinMaxPrice {
  MinMaxPrice({
      this.minPrice, 
      this.maxPrice, 
      this.specialPrice, 
      this.maxSpecialPrice, 
      this.discountInPercentage,});

  MinMaxPrice.fromJson(dynamic json) {
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    specialPrice = json['special_price'];
    maxSpecialPrice = json['max_special_price'];
    discountInPercentage = json['discount_in_percentage'];
  }
  num? minPrice;
  num? maxPrice;
  num? specialPrice;
  num? maxSpecialPrice;
  num? discountInPercentage;
MinMaxPrice copyWith({  num? minPrice,
  num? maxPrice,
  num? specialPrice,
  num? maxSpecialPrice,
  num? discountInPercentage,
}) => MinMaxPrice(  minPrice: minPrice ?? this.minPrice,
  maxPrice: maxPrice ?? this.maxPrice,
  specialPrice: specialPrice ?? this.specialPrice,
  maxSpecialPrice: maxSpecialPrice ?? this.maxSpecialPrice,
  discountInPercentage: discountInPercentage ?? this.discountInPercentage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['min_price'] = minPrice;
    map['max_price'] = maxPrice;
    map['special_price'] = specialPrice;
    map['max_special_price'] = maxSpecialPrice;
    map['discount_in_percentage'] = discountInPercentage;
    return map;
  }

}

class Variants {
  Variants({
      this.id, 
      this.productId, 
      this.attributeValueIds, 
      this.attributeSet, 
      this.price, 
      this.specialPrice, 
      this.sku, 
      this.stock, 
      this.images, 
      this.availability, 
      this.status, 
      this.dateAdded, 
      this.variantIds, 
      this.attrName, 
      this.variantValues, 
      this.swatcheType, 
      this.swatcheValue, 
      this.imagesMd, 
      this.imagesSm, 
      this.cartCount,});

  Variants.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    attributeValueIds = json['attribute_value_ids'];
    attributeSet = json['attribute_set'];
    price = json['price'];
    specialPrice = json['special_price'];
    sku = json['sku'];
    stock = json['stock'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add((v));
      });
    }
    availability = json['availability'];
    status = json['status'];
    dateAdded = json['date_added'];
    variantIds = json['variant_ids'];
    attrName = json['attr_name'];
    variantValues = json['variant_values'];
    swatcheType = json['swatche_type'];
    swatcheValue = json['swatche_value'];
    if (json['images_md'] != null) {
      imagesMd = [];
      json['images_md'].forEach((v) {
        imagesMd?.add((v));
      });
    }
    if (json['images_sm'] != null) {
      imagesSm = [];
      json['images_sm'].forEach((v) {
        imagesSm?.add((v));
      });
    }
    cartCount = json['cart_count'];
  }
  String? id;
  String? productId;
  String? attributeValueIds;
  String? attributeSet;
  String? price;
  String? specialPrice;
  String? sku;
  dynamic stock;
  List<dynamic>? images;
  String? availability;
  String? status;
  String? dateAdded;
  String? variantIds;
  String? attrName;
  String? variantValues;
  String? swatcheType;
  String? swatcheValue;
  List<dynamic>? imagesMd;
  List<dynamic>? imagesSm;
  String? cartCount;
Variants copyWith({  String? id,
  String? productId,
  String? attributeValueIds,
  String? attributeSet,
  String? price,
  String? specialPrice,
  String? sku,
  dynamic stock,
  List<dynamic>? images,
  String? availability,
  String? status,
  String? dateAdded,
  String? variantIds,
  String? attrName,
  String? variantValues,
  String? swatcheType,
  String? swatcheValue,
  List<dynamic>? imagesMd,
  List<dynamic>? imagesSm,
  String? cartCount,
}) => Variants(  id: id ?? this.id,
  productId: productId ?? this.productId,
  attributeValueIds: attributeValueIds ?? this.attributeValueIds,
  attributeSet: attributeSet ?? this.attributeSet,
  price: price ?? this.price,
  specialPrice: specialPrice ?? this.specialPrice,
  sku: sku ?? this.sku,
  stock: stock ?? this.stock,
  images: images ?? this.images,
  availability: availability ?? this.availability,
  status: status ?? this.status,
  dateAdded: dateAdded ?? this.dateAdded,
  variantIds: variantIds ?? this.variantIds,
  attrName: attrName ?? this.attrName,
  variantValues: variantValues ?? this.variantValues,
  swatcheType: swatcheType ?? this.swatcheType,
  swatcheValue: swatcheValue ?? this.swatcheValue,
  imagesMd: imagesMd ?? this.imagesMd,
  imagesSm: imagesSm ?? this.imagesSm,
  cartCount: cartCount ?? this.cartCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['attribute_value_ids'] = attributeValueIds;
    map['attribute_set'] = attributeSet;
    map['price'] = price;
    map['special_price'] = specialPrice;
    map['sku'] = sku;
    map['stock'] = stock;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['availability'] = availability;
    map['status'] = status;
    map['date_added'] = dateAdded;
    map['variant_ids'] = variantIds;
    map['attr_name'] = attrName;
    map['variant_values'] = variantValues;
    map['swatche_type'] = swatcheType;
    map['swatche_value'] = swatcheValue;
    if (imagesMd != null) {
      map['images_md'] = imagesMd?.map((v) => v.toJson()).toList();
    }
    if (imagesSm != null) {
      map['images_sm'] = imagesSm?.map((v) => v.toJson()).toList();
    }
    map['cart_count'] = cartCount;
    return map;
  }

}