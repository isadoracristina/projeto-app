import 'dart:convert';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_despensa/models/recipe.dart';
import 'api_service.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key, required this.title, required this.recipes})
      : super(key: key);
  final String title;
  final List<Recipe> recipes;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  var api_service = ApiServices();

  var inputIngredientFilter = TextEditingController();
  var inputTagFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: inputIngredientFilter,
            ),
            TextFormField(
              controller: inputTagFilter,
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () async {
                var allIngredients = await api_service.getAllIngredients();

                var ingredients = inputIngredientFilter.text.split(', ');
                var selected_ingredients = allIngredients
                    .where((i) => ingredients.contains(i.name))
                    .toList();

                var tags = inputIngredientFilter.text.split(' ');

                var byIngredientList = await api_service
                    .getRecipesFilteredByIngredients(selected_ingredients);

                print(byIngredientList);
                //var byTagList =
                //await api_service.getRecipesFilteredByTags(widget.recipes);

                //var list = [byIngredientList, byTagList];

                //final common = list.fold<Set>(
                //  list.first.toSet(), (a, b) => a.intersection(b.toSet()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
