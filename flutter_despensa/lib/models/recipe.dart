class Recipe {
  late int id;
  late String name;
  late int time;
  late String picture;
  late List<String> tags;
  late List<String> ingredients;
  late String preparation;
  late int classification;

  Recipe({required this.id, required this.name, required this.time,
    required this.picture, required this.tags, required this.ingredients,
    required this.preparation, required this.classification});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    time = json['time'];
    picture = json['picture'];
    tags = json['tags'];
    ingredients = json['ingredients'];
    preparation = json['preparation'];
    classification = json['classification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['time'] = time;
    data['picture'] = picture;
    data['tags'] = tags;
    data['ingredients'] = ingredients;
    data['preparation'] = preparation;
    data['classification'] = classification;
    return data;
  }
}