import 'recipe.dart';

class User {
  late int id;
  late String name;
  late String lastName;
  late List<Recipe> recipes;

  User({required this.id, required this.name, required this.lastName, required this.recipes});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id_user'];
    name = json['name_user'];
    //lastName = json['lastName'];
    //recipes = json['recipes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['recipes'] = recipes;
    return data;
  }
}
