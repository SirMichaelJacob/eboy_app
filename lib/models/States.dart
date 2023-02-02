// ignore_for_file: file_names

class States {
  String state;
  List<dynamic> lgas;

  States({this.state, this.lgas});

  factory States.fromJson(Map<String, dynamic> json) {
    return States(
        state: json['state'] as String,
        lgas: json['lgas'] as List<dynamic>) ;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['state'] = state;
    map['lgas'] = lgas;
    return map;
  }
}
