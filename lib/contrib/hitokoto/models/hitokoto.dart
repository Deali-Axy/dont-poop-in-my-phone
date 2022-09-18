class Hitokoto {
  int id;
  String hitokoto;
  String type;
  String fromWhere;
  String creator;
  int createdAt;

  Hitokoto({this.id, this.hitokoto, this.type, this.fromWhere, this.creator, this.createdAt});

  Hitokoto.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["hitokoto"] is String) this.hitokoto = json["hitokoto"];
    if (json["type"] is String) this.type = json["type"];
    if (json["from_where"] is String) this.fromWhere = json["from_where"];
    if (json["creator"] is String) this.creator = json["creator"];
    if (json["created_at"] is int) this.createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["hitokoto"] = this.hitokoto;
    data["type"] = this.type;
    data["from_where"] = this.fromWhere;
    data["creator"] = this.creator;
    data["created_at"] = this.createdAt;
    return data;
  }
}
