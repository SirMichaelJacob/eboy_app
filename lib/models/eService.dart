// ignore_for_file: file_names

class EService {
  String id;
  String name;
  String description;
  String available;

  EService({this.id, this.name, this.description, this.available});

  factory EService.fromJson(Map<String, dynamic> json) {
    return EService(
        id: json['id'] as String,
        name: json['name'],
        description: json['description'],
        available: json['available']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['available'] = available;
    return map;
  }
}
