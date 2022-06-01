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

    var tag_list = [];
    if (json['tags'] != null) {
      tag_list = json['tags'] as List;
    }

    List<String> tagList =
        tag_list.map((i) => Tag.fromJson(i).toString()).toList();
    List<String> ingredientList =
        ing_list.map((i) => IngredientRel.fromJson(i).toString()).toList();

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

class IngredientRel {
  late int id_recipe;
  late int id_ingredient;
  late double? amount;
  late String? name;
  late String? measurement;

  IngredientRel(
      {required this.id_recipe,
      required this.id_ingredient,
      required this.name,
      required this.amount,
      required this.measurement});

  IngredientRel.fromJson(Map<String, dynamic> parsedJson) {
    IngredientRel(
        id_recipe: parsedJson['id_recipe'],
        id_ingredient: parsedJson['id_ingredient'],
        name: parsedJson['name'],
        amount: parsedJson['amount'],
        measurement: parsedJson['measurement']);
  }
}

class Ingredient {
  late int id;
  late String name;

  Ingredient({required this.id, required this.name});

  Ingredient.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id_ingredient'];
    name = parsedJson['name_ingredient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['recipes'] = [];
    return data;
  }
}
