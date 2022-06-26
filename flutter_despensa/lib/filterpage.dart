import 'dart:convert';

import 'dart:developer';
import 'package:flutter_despensa/filteredpage.dart';

import 'recipelistpage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_despensa/models/recipe.dart';
import 'api_service.dart';

class FilterPage extends StatefulWidget {



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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 147, 58),
        title: const Text(
          'Filtrar Receitas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => RecipeListPage())
                )
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15), 
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("Nome da Receita",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Pesquisa por nome",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Ingrediente",
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 10
          ),
          TextFormField(
            key: const Key("Ingredients"),
            controller: inputIngredientFilter,
            decoration: InputDecoration(
              hintText: "Pesquisa por ingrediente",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("TAG",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: inputTagFilter,
            decoration: InputDecoration(
              hintText: "Pesquisa por TAG",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ),
          const SizedBox(
            height: 25
          ),
          ElevatedButton(
            key: const Key("Filter"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
              shadowColor: const Color.fromARGB(255, 241, 147, 58),
            ),
            child: const Text('Filtrar',
              style: TextStyle(
                color: Colors.white
              ),
            ),
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

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => FilteredPage(byIngredientList)
                  )
                )
              );
            },
          ),
        ],
      ),
    )
    );
  }
}
