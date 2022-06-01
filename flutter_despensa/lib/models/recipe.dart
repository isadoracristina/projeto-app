class Recipe {
  late int id;
  late String name;
  late int time;
  late String picture;
  late List<String> tags;
  late List<String> ingredients;
  late String preparation;
  late double classification;

  Recipe(
      {required this.id,
      required this.name,
      required this.time,
      required this.picture,
      required this.tags,
      required this.ingredients,
      required this.preparation,
      required this.classification});

  Recipe.fromJson(Map<String, dynamic> json) {
    var ing_list = json['ingredients'] as List;
    var tag_list = json['tags'] as List;

    List<String> tagList =
        tag_list.map((i) => Tag.fromJson(i).toString()).toList();
    List<String> ingredientList = ing_list.map((i) => Ingredient.fromJson(i).toString()).toList();

    id = json['id'];
    name = json['name'];
    time = json['preparation_time_sec'] ~/ 60;
    //picture = json['picture'];
    tags = tagList;
    ingredients = ingredientList;
    preparation = json['preparation_method'];
    classification = json['rating'];
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

class Tag {
  late int id;

  Tag({required this.id});

  Tag.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    id:
    parsedJson['id_tag'];
  }
}

class Ingredient {
  late int id;
  late double amount;
  late String measurement;

  Ingredient(
      {required this.id, required this.amount, required this.measurement});

  Ingredient.fromJson(Map<String, dynamic> parsedJson) {
    Ingredient(
        id: parsedJson['id_ingredient'],
        amount: parsedJson['amount'],
        measurement: parsedJson['measurement']);
  }
}
