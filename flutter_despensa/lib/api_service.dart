import 'package:flutter_despensa/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  updateToken(String token) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  login(String username, String password) async {
    var preferences = await SharedPreferences.getInstance();
    var api_root = await preferences.getString('api_root') as String;

    var body_str =
        'grant_type=password&username=${username}&password=${password}';

    var response = await http.post(
      Uri.parse(api_root + '/token'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body_str,
    );

    // Tratar caso resposta não seja OK
    var body_json = json.decode(response.body);
    var token = body_json['token_type'] + ' ' + body_json['access_token'];
    preferences.setString('token', token);
    preferences.setBool('is_logged_in', true);
  }

  register(String username, String email, String password) async {
    var preferences = await SharedPreferences.getInstance();
    var api_root = await preferences.getString('api_root') as String;

    var response = await http.post(
      Uri.parse(api_root + '/user'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password
      }),
    );

    // Tratar caso resposta não seja OK
  }

  getRecipeById(int id) async {
    var preferences = await SharedPreferences.getInstance();
    var api_root = await preferences.getString('api_root') as String;

    var response = await http.get(
        Uri.parse(api_root + '/recipe/' + id.toString()),
        headers: <String, String>{
          'Authorization': await preferences.getString('token') as String,
        });

    // Tratar caso resposta não seja OK
    return json.decode(utf8.decode(response.bodyBytes));
  }

  getUser() async {
    var preferences = await SharedPreferences.getInstance();
    var api_root = await preferences.getString('api_root') as String;

    var response = await http
        .get(Uri.parse(api_root + '/user/me'), headers: <String, String>{
      'Authorization': await preferences.getString('token') as String,
    });

    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<List<Recipe>> getAllRecipes() async {
    var preferences = await SharedPreferences.getInstance();
    var api_root = await preferences.getString('api_root') as String;

    var response = await http
        .get(Uri.parse(api_root + '/recipe/'), headers: <String, String>{
      'Authorization': await preferences.getString('token') as String,
    });

    var recipe_list = json.decode(utf8.decode(response.bodyBytes)) as List;
    var recipes = recipe_list.map((r) => Recipe.fromJson(r)).toList();

    return recipes;
  }

  Future<List<Ingredient>> getAllIngredients() async {
    var preferences = await SharedPreferences.getInstance();
    var api_root = await preferences.getString('api_root') as String;

    var response = await http
        .get(Uri.parse(api_root + '/ingredient/'), headers: <String, String>{
      'Authorization': await preferences.getString('token') as String,
    });

    var ingredient_list = json.decode(utf8.decode(response.bodyBytes)) as List;

    var ingredients =
        ingredient_list.map((r) => Ingredient.fromJson(r)).toList();

    return ingredients;
  }

  Future<List<Recipe>> getRecipesFilteredByIngredients(
      List<Ingredient> filter) async {
    var preferences = await SharedPreferences.getInstance();
    var api_root = await preferences.getString('api_root') as String;

    var response =
        await http.post(Uri.parse(api_root + '/recipe/filter/ingredient/'),
            headers: <String, String>{
              'Authorization': await preferences.getString('token') as String,
              'Content-Type': "application/json",
            },
            body: json.encode(filter));

    var recipe_list = json.decode(utf8.decode(response.bodyBytes)) as List;
    var recipes = recipe_list.map((r) => Recipe.fromJson(r)).toList();

    return recipes;
  }

  Future<List<Recipe>> getRecipesFilteredByTags(List<Tag> filter) async {
    var preferences = await SharedPreferences.getInstance();
    var api_root = await preferences.getString('api_root') as String;

    var response = await http.post(Uri.parse(api_root + '/recipe/filter/tag'),
        headers: <String, String>{
          'Authorization': await preferences.getString('token') as String,
          'Content-Type': "application/json",
        },
        body: <String, String>{
          'tag_list': jsonEncode(filter),
        });

    var recipe_list = json.decode(utf8.decode(response.bodyBytes)) as List;
    var recipes = recipe_list.map((r) => Recipe.fromJson(r)).toList();

    return recipes;
  }

  registerRecipe(Recipe recipe) async {
    var preferences = await SharedPreferences.getInstance();
    var api_root = await preferences.getString('api_root') as String;

    var response = await http.post(Uri.parse(api_root + '/recipe/'),
        headers: <String, String>{
          'Authorization': await preferences.getString('token') as String,
          'Content-Type': "application/json",
        },
        body: jsonEncode(recipe));

      print(response.body);
  }
}
