import 'package:flutter/material.dart';
import 'package:flutter_despensa/models/recipe.dart';
import 'package:flutter_despensa/recipelistpage.dart';
import 'models/recipe.dart';

class RecipePage extends StatelessWidget {


  var recipe = Recipe(id: 1, name: "Waffle", time: 20, picture: "abc", tags: ["café", "pratica"], ingredients: ["farinha", "ovos"], preparation: "Misture tudo", classification: 4);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 147, 58),
        title: const Text('Minhas Receitas',
          style: TextStyle(
            fontWeight: FontWeight.bold
            ),
        ),
        actions: <Widget> [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeListPage()
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                Text(recipe.name,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 241, 147, 58),
                  )
                ),
                const SizedBox(
                  width: 50,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  decoration: BoxDecoration(
                    color:Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text(recipe.time.toString() + " min",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.orangeAccent,
                height: 200,
                width: 300,
                child: const Text("Imagem da Receita",
                  textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: recipe.tags.length,
                separatorBuilder: (BuildContext ctxt, int index) => const Divider(thickness: 50, color: Colors.transparent,),
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    decoration: BoxDecoration(
                      color:Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(recipe.tags[index],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  );
                },
              )
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Ingredientes",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 105, 105, 105)
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orangeAccent
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: recipe.ingredients.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Text(recipe.ingredients[index],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Modo de Preparo",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 105, 105, 105)
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orangeAccent
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(recipe.preparation)
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              decoration: BoxDecoration(
                color:Colors.orangeAccent,
                borderRadius: BorderRadius.circular(10)
                ),
              child: RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.star,
                        color: Colors.white,
                        size: 15),
                    ),
                    TextSpan(
                      text: " " + recipe.classification.toString(),
                        style: const TextStyle(
                          color: Colors.white
                        )
                    )
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}