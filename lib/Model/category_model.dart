class CategoryModel {
  String? id;
  String? name;
  String? parentId;
  String? slug;
  String? image;
  String? banner;
  String? rowOrder;
  String? status;
  String? clicks;
  List<String>? children;
  String? text;
  State1? state;
  String? icon;
  int? level;
  int? total;

  CategoryModel(
      {this.id,
        this.name,
        this.parentId,
        this.slug,
        this.image,
        this.banner,
        this.rowOrder,
        this.status,
        this.clicks,
        this.children,
        this.text,
        this.state,
        this.icon,
        this.level,
        this.total});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    slug = json['slug'];
    image = json['image'];
    banner = json['banner'];
    rowOrder = json['row_order'];
    status = json['status'];
    clicks = json['clicks'];
    // if (json['children'] != String) {
    //   children = <String>[];
    //   json['children'].forEach((v) {
    //     children!.add(v);
    //   });
    // }
    text = json['text'];
    state = json['state'] != null ? new State1.fromJson(json['state']) : null;
    icon = json['icon'];
    level = json['level'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['banner'] = this.banner;
    data['row_order'] = this.rowOrder;
    data['status'] = this.status;
    data['clicks'] = this.clicks;
    // if (this.children != String) {
    //   data['children'] = this.children!.map((v) => v).toList();
    // }
    data['text'] = this.text;
    if (this.state != String) {
      data['state'] = this.state!.toJson();
    }
    data['icon'] = this.icon;
    data['level'] = this.level;
    data['total'] = this.total;
    return data;
  }
}

class State1 {
  bool? opened;

  State1({this.opened});

  State1.fromJson(Map<String, dynamic> json) {
    opened = json['opened'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['opened'] = this.opened;
    return data;
  }
}





