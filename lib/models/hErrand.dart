// ignore_for_file: file_names

class HErrand {
  String id;
  String appartmentType;
  String address;
  String state;
  String lg;
  String phone;
  String startdate;
  String enddate;
  String frequency;
  String status; 

  HErrand(
      {this.id,
      this.appartmentType,
      this.address,
      this.state,
      this.lg,
      this.phone,
      this.startdate,
      this.enddate,
      this.frequency,
      this.status});

  factory HErrand.fromJson(Map<String, dynamic> json) {
    return HErrand(
        id: json['id'],
        appartmentType: json['appartmentType'],
        address: json['address'],
        state: json['state'],
        lg: json['lg'],
        phone: json['phone'],
        startdate: json['startdate'],
        enddate: json['enddate'],
        frequency: json['frequency'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['appartmentType'] = appartmentType;
    map['address'] = address;
    map['state'] = state;
    map['lg'] = lg;
    map['phone'] = phone;
    map['startdate'] = startdate;
    map['enddate'] = enddate;
    map['frequency'] = frequency;
    map['status'] = status;
    return map;
  }
}
