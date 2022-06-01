import 'package:email_validator/email_validator.dart';

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
    var ing_list = json['ingredients_names'] as List;
    var tag_list = json['tags_names'] as List;

    List<String> tagList = tag_list.map((i) => Tag.fromJson(i).name).toList();
    List<String> ingredientList = ing_list.map((i) {
        var ing = IngredientRel.fromJson(i);
        return "${ing.amount} ${ing.measurement}  ${ing.name}";
    }).toList();

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
    data['id_user'] = 0;
    data['name'] = name;
    data['img_addr'] = picture;
    data['preparation_time_sec'] = time;
    data['preparation_method'] = preparation;
    data['observation'] = ' ';
    data['pantry_only'] = false;
    data['tags'] = [];
    data['ingredients'] = [];
    data['rating'] = classification;
    return data;
  }
}

class TagRel {
  late int id_tag;
  late int id_recipe;

  TagRel({required this.id_tag, required this.id_recipe});

  factory TagRel.fromJson(Map<String, dynamic> parsedJson) {
    return TagRel(
      id_tag: parsedJson['id_tag'], id_recipe: parsedJson['id_recipe']);
  }
}

class Tag {
  late int id;
  late String name;

  Tag({required this.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> parsedJson) {
    return Tag(id: parsedJson['id_tag'], name: parsedJson['description_tag']);
  }
}

class IngredientRel {
  late int id_recipe;
  late int? id_ingredient;
  late double amount;
  late String name;
  late String measurement;

  IngredientRel(
    {required this.id_recipe,
      required this.id_ingredient,
      required this.name,
      required this.amount,
      required this.measurement});

  factory IngredientRel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return IngredientRel(
      id_recipe: parsedJson['id'],
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
