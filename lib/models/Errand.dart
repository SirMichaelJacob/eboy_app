// ignore_for_file: file_names

class Errand {
  String id;
  String item;
  String state;
  String pickupLG;
  String pickupLocation;
  String destinationLG;
  String destination;
  String receiverPhone;
  String pickupDate;
  String deliveryDate;
  String status;

  Errand(
      {this.id,
      this.item,
      this.state,
      this.pickupLG,
      this.pickupLocation,
      this.destinationLG,
      this.destination,
      this.receiverPhone,
      this.pickupDate,
      this.deliveryDate,
      this.status});

  factory Errand.fromJson(Map<String, dynamic> json) {
    return Errand(
        id: json['id'] as String,
        item: json['item'] as String,
        state: json['state'] as String,
        pickupLG: json['pickupLG'] as String,
        pickupLocation: json['pickupLocation'] as String,
        destinationLG: json['destinationLG'] as String,
        destination: json['destination'] as String,
        receiverPhone: json['receiverPhone'] as String,
        pickupDate: json['pickupDate'] as String,
        deliveryDate: json['deliveryDate'] as String,
        status: json['status'] as String);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['item'] = item;
    map['state'] = state;
    map['pickupLG'] = pickupLG;
    map['pickupLocation'] = pickupLocation;
    map['destinationLG'] = destinationLG;
    map['destination'] = destination;
    map['receiverPhone'] = receiverPhone;
    map['pickupDate'] = pickupDate;
    map['deliveryDate'] = deliveryDate;
    map['status'] = status;
    return map;
  }
}
