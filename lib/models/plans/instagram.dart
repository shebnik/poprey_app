import 'dart:convert';

class Instagram {
  final likes;

  Instagram({
    this.likes,
  });

  factory Instagram.fromJson(dynamic json) {
    var likesJson = json['Likes'];

      var plansObjsJson = likesJson['plans'] as List;
      List<Plans> _plans =
          plansObjsJson.map((plansJson) => Plans.fromJson(plansJson)).toList();

      return Instagram(
        likes: _plans,
      );
  }
}

class Plans {
  final String count;

  Plans({
    required this.count,
  });

  Plans.fromJson(Map json) : count = json["count"];
}
