import 'package:flutter/material.dart';
import 'package:flutter_despensa/api_service.dart';
import 'package:flutter_despensa/newrecipepage.dart';
import 'package:flutter_despensa/recipepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/recipe.dart';
import 'models/user.dart';
import 'dart:convert';
import 'userpage.dart';
import 'recipepage.dart';
import 'newrecipepage.dart';
import 'filterpage.dart';

class RecipeListPage extends StatefulWidget {
  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  late Future<List<Recipe>> futureRecipes;

  getUserName() async {
    var api = ApiServices();
    var result = await api.getUser();
    return User.fromJson(result).name;
  }

Future<List<Recipe>> getRecipes() async {
    var api = ApiServices();
    var recipes = await api.getAllRecipes();
    return recipes;
  }

  @override
  void initState() {
    super.initState();
    futureRecipes = getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    Future load() async {
      var prefs = await SharedPreferences.getInstance();
      var data = prefs.getString('data');

      if (data != null) {
        Iterable decoded = jsonDecode(data);
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 241, 147, 58),
          title: const Text(
            'Minhas Receitas',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () async {
                final name = await getUserName();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => UserPage(name))));
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: FutureBuilder<List<Recipe>>(
                    future: futureRecipes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Dismissible(
                                background: Container(
                                  color:
                                      const Color.fromARGB(255, 243, 192, 116)
                                          .withOpacity(0.2),
                                ),
                                key: Key(snapshot.data![index].name),
                                onDismissed: (direction) {
                                  //remove(index);
                                },
                                child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.all(8),
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.orangeAccent),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        RecipePage(snapshot.data![index]))));
                                          },
                                          child:
                                              Text(snapshot.data![index].name),
                                        ),
                                        ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics: const ClampingScrollPhysics(),
                                            itemCount: snapshot
                                                .data![index].tags.length,
                                            itemBuilder: (BuildContext context, int index2) {
                                              return Container(
                                                height: 30,
                                                alignment: Alignment.centerRight,
                                                margin: const EdgeInsets.all(3),
                                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                decoration: BoxDecoration(
                                                  color:const Color.fromARGB(255, 248,190,114),
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Center(
                                                  child: Text(snapshot.data![index].tags[index2],
                                                    style: const TextStyle(
                                                    color: Colors.white,
                                                    )
                                                  ),
                                                )
                                              );
                                            }
                                        )
                                      ],
                                    )
                                  )
                                );
                          },
                        );
                      } else {
                        return Text("${snapshot.error}");
                      }
                    }),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => NewRecipePage())));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        shadowColor: const Color.fromARGB(255, 241, 147, 58),
                      ),
                      child: RichText(
                        text: const TextSpan(children: [
                          WidgetSpan(
                            child:
                                Icon(Icons.add, color: Colors.white, size: 15),
                          ),
                          TextSpan(
                              text: "Nova Receita",
                              style: TextStyle(color: Colors.white))
                        ]),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                            builder: ((context) => FilterPage())
                            )
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                          shadowColor: const Color.fromARGB(255, 241, 147, 58),
                        ),
                        child: RichText(
                            text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.filter_alt,
                                  color: Colors.white, size: 15),
                            ),
                            TextSpan(
                                text: "Filtrar Receitas",
                                style: TextStyle(color: Colors.white))
                          ],
                        )))
                  ])
            ])));
  }
}
