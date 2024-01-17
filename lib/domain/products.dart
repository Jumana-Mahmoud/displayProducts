import 'categories.dart';

class Products {
  int? id;
  String? title;
  int? price;
  String? description;
  Categories? category;
  List<String>? images;

  Products(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category =
    json['category'] != null ? Categories.fromJson(json['category']) : null;
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['images'] = images;
    return data;
  }
}
