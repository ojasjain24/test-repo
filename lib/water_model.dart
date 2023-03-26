import 'dart:convert';

Water basicProfileFromJson(String str) =>
    Water.fromJson(json.decode(str));

String basicProfileToJson(Water data) => json.encode(data.toJson());

class Water {
  String? created_at;
  String? field1;
  String? field2;
  int? entry_id;

  Water({this.created_at, this.field1, this.field2, this.entry_id});

  factory Water.fromJson(Map<String, dynamic>? json) {
    json = json ?? {};
    return Water(
      entry_id: json["entry_id"],
      field2: json["field2"],
      field1: json["field1"],
      created_at: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "entry_id": entry_id,
    "field2": field2,
    "field1": field1,
    "created_at": created_at,
  };
}
