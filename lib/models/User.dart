// ignore_for_file: file_names

class User {
  String id;
  String firstname;
  String lastname;
  String email;
  String phone;
  String password;

  User(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.password});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map['id'] as String,
        firstname: map['firstName'] as String,
        lastname: map['lastName'] as String,
        email: map['email'] as String,
        phone: map['phone'] as String,
        password: map['password'] as String);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstname;
    map['lastName'] = lastname;
    map['email'] = email;
    map['phone'] = phone;
    map['password'] = password;

    return map;
  }
}
