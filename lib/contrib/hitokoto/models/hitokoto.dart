/// id : 23
/// hitokoto : "像平常的你一样引发奇迹吧-"
/// type : "a"
/// from_where : "魔法少女小圆"
/// creator : "ludk60"
/// created_at : 1468540800.0

class Hitokoto {
  Hitokoto({
    num? id,
    required String hitokoto,
    String? type,
    String? fromWhere,
    required String creator,
    num? createdAt,
  }) {
    _id = id;
    _hitokoto = hitokoto;
    _type = type;
    _fromWhere = fromWhere;
    _creator = creator;
    _createdAt = createdAt;
  }

  Hitokoto.fromJson(dynamic json) {
    _id = json['id'];
    _hitokoto = json['hitokoto'];
    _type = json['type'];
    _fromWhere = json['from_where'];
    _creator = json['creator'];
    _createdAt = json['created_at'];
  }

  num? _id;
  late String _hitokoto;
  String? _type;
  String? _fromWhere;
  late String _creator;
  num? _createdAt;

  Hitokoto copyWith({
    num? id,
    String? hitokoto,
    String? type,
    String? fromWhere,
    String? creator,
    num? createdAt,
  }) =>
      Hitokoto(
        id: id ?? _id,
        hitokoto: hitokoto ?? _hitokoto,
        type: type ?? _type,
        fromWhere: fromWhere ?? _fromWhere,
        creator: creator ?? _creator,
        createdAt: createdAt ?? _createdAt,
      );

  num? get id => _id;

  String get hitokoto => _hitokoto;

  String? get type => _type;

  String? get fromWhere => _fromWhere;

  String get creator => _creator;

  num? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['hitokoto'] = _hitokoto;
    map['type'] = _type;
    map['from_where'] = _fromWhere;
    map['creator'] = _creator;
    map['created_at'] = _createdAt;
    return map;
  }
}
