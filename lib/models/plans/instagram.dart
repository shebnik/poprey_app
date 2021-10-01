import 'dart:convert';

class Instagram {
  final List<Plan> likes;

  Instagram({
    required this.likes,
  });

  factory Instagram.fromJson(json) {
    var likesJson = json['Likes'];

    var plansObjsJson = likesJson['plans'] as List;
    List<Plan> _plans =
        plansObjsJson.map((plansJson) => Plan.fromJson(plansJson)).toList();

    return Instagram(
      likes: _plans,
    );
  }
}

class Plan {
  final int count;
  final double price;
  final Map<String, Type> types;
  final Extra? extra;

  Plan({
    required this.count,
    required this.price,
    required this.types,
    this.extra,
  });

  factory Plan.fromJson(json) {
    var typesJson = json["types"];

    return Plan(
      count: int.parse(json["count"]),
      price: double.parse(json["price"]),
      types: {
        "t1": Type.fromJson(typesJson["t1"]),
        "t2": Type.fromJson(typesJson["t2"]),
      },
    );
  }
}

class Type {
  final String name;
  final double price;
  final bool disabled;
  final bool discount;

  Type({
    required this.name,
    required this.price,
    required this.disabled,
    required this.discount,
  });

  factory Type.fromJson(json) {
    return Type(
      name: json["name"],
      price: double.parse(json["price"]),
      disabled: int.parse(json["disabled"]) == 1 ? true : false,
      discount: int.parse(json["discount"]) == 1 ? true : false,
    );
  }
}

class Extra {}
