class User {
  late int id;
  late String name;
  late String lastName;

  User({required this.id, required this.name, required this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    return data;
  }
}