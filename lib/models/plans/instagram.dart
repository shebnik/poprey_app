class Instagram {
  final List<Plan> likes;
  final List<Plan> followers;
  final List<Plan> autoLikesPost;
  final List<Plan> autoLikesSubs;
  final List<Plan> views;
  final List<Plan> comments;

  Instagram({
    required this.likes,
    required this.followers,
    required this.autoLikesPost,
    required this.autoLikesSubs,
    required this.views,
    required this.comments,
  });

  factory Instagram.fromJson(json) {
    var likes = json['Likes']['plans'] as List;
    List<Plan> _likes = likes.map((_) => Plan.fromJson(_)).toList();

    var followers = json['Followers']['plans'] as List;
    List<Plan> _followers = followers.map((_) => Plan.fromJson(_)).toList();

    var autoLikes = json['Auto-Likes']['plans'] as List;
    List<Plan> _autoLikesPost = autoLikes.map((_) => Plan.fromJson(_)).toList();

    var views = json['Views']['plans'] as List;
    List<Plan> _views = views.map((_) => Plan.fromJson(_)).toList();

    var comments = json['Comments']['plans'] as List;
    List<Plan> _comments = comments.map((_) => Plan.fromJson(_)).toList();

    var autoLikesSubs = json['Auto-Likes Subs']['plans'] as List;
    List<Plan> _autoLikesSubs =
        autoLikesSubs.map((_) => Plan.fromJson(_)).toList();

    return Instagram(
      likes: _likes,
      followers: _followers,
      autoLikesPost: _autoLikesPost,
      autoLikesSubs: _autoLikesSubs,
      views: _views,
      comments: _comments,
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
    var typesJson = json['types'];

    return Plan(
      count: int.parse(json['count']),
      price: double.parse(json['price']),
      types: {
        't1': Type.fromJson(typesJson['t1']),
        't2': Type.fromJson(typesJson['t2']),
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
      name: json['name'],
      price: double.parse(json['price']),
      disabled: int.tryParse(json['disabled'].toString()) == 1 ? true : false,
      discount: int.tryParse(json['discount'].toString()) == 1 ? true : false,
    );
  }
}

class Extra {}
