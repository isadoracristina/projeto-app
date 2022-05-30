import 'package:flutter/material.dart';
import 'models/recipe.dart';
import 'models/user.dart';

class RecipeListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var recipe1 = Recipe(id: 1, name: "Waffle1", time: 20, picture: "abc", tags: ["café", "pratica", "simpes"], ingredients: ["farinha", "ovos"], preparation: "Misture tudo", classification: 4);
  
    var recipe2 = Recipe(id: 2, name: "Waffle2", time: 20, picture: "abc", tags: ["café"], ingredients: ["farinha", "ovos"], preparation: "Misture tudo", classification: 4);
  
    var recipe3 = Recipe(id: 3, name: "Waffle3", time: 20, picture: "abc", tags: ["café", "pratica"], ingredients: ["farinha", "ovos"], preparation: "Misture tudo", classification: 4);
  
    var user = User(id: 1, name: "Juca", lastName: "Silva", recipes: [recipe1, recipe2, recipe3]);


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
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)                  
                ),
                hintText: "Digite o nome da receita",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {},
                )
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: user.recipes.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    decoration: BoxDecoration(
                      border:Border.all(
                        color: Colors.orangeAccent
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(user.recipes[index].name),
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: user.recipes[index].tags.length,
                          itemBuilder: (BuildContext context, int index2) {
                            return Container(
                              height: 30,
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.all(3),
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                color:const Color.fromARGB(255, 248, 190, 114),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(user.recipes[index].tags[index2],
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
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                shadowColor: const Color.fromARGB(255, 241, 147, 58),
              ),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.add,
                        color: Colors.white,
                        size: 15),
                    ),
                    TextSpan(
                      text: "Nova Receita ",
                        style: TextStyle(
                          color: Colors.white
                        )
                    )
                  ]
                ),
              ),
            ),
          ],
        )
      )   
    );
    
  }
}