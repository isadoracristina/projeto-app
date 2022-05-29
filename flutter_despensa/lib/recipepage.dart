import 'package:flutter/material.dart';
import 'package:flutter_despensa/models/recipe.dart';
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
            onPressed: () {},
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
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                Text(recipe.name,
                  style: const TextStyle(
                    fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}