import 'package:flutter/material.dart';
import 'package:flutter_despensa/recipelistpage.dart';
import 'recipelistpage.dart';

import 'models/recipe.dart';
import 'api_service.dart';

class NewRecipePage extends StatefulWidget {
  @override
  State<NewRecipePage> createState() => _NewRecipePageState();
}

class _NewRecipePageState extends State<NewRecipePage> {
  // teste() async {
  //   var api_service = ApiServices();
  //   await api_service.register('leroy', 'leroy@email.com', 'senhaleroy');
  //   await api_service.login('leroy', 'senhaleroy');
  //   var result = await api_service.getRecipeById(1);
  //   print(result);
  // }

  late TextEditingController inputrecipename;
  late TextEditingController inputrecipetime;
  late TextEditingController inputrecipepreparations;
  late TextEditingController inputrecipetag;
  
  String tag = "";

  @override
  void initState (){
    super.initState();

    inputrecipename = TextEditingController();
    inputrecipetime = TextEditingController();
    inputrecipepreparations = TextEditingController();
    inputrecipetag = TextEditingController();
  }

  @override
  void dispose(){
    inputrecipetag.dispose();

    super.dispose();

  }

  void addIngredient(){
    setState(() {
      
    });
  }

  void addTag(){
    setState(() {
      
    });
  }



  @override

      Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Inclua uma TAG",
          style: TextStyle(
            color: Colors.orangeAccent
          ),
        ),
        content: TextField(
          controller: inputrecipetag,
          decoration: const InputDecoration(
            hintText: "prática, café, rápida..."
          ),
        ),
        actions: [
          TextButton(
            autofocus: true,
            child: const Text("ADICIONAR"),
            onPressed: submit()
          )
        ],
      )
    );

    submit(){
      Navigator.of(context).pop(inputrecipetag.text);
    }
    
  Widget build(BuildContext context) {
    //teste();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 147, 58),
        title: const Text(
          'Nova Receita',
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Nome",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 105, 105, 105)),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: inputrecipename,
              maxLines: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Digite o nome da receita"),
              onSaved: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                shadowColor: const Color.fromARGB(255, 241, 147, 58),
              ),
              child: RichText(
                text: const TextSpan(children: [
                  WidgetSpan(
                    child: Icon(Icons.add, color: Colors.white, size: 15),
                  ),
                  TextSpan(
                      text: "Incluir Foto",
                      style: TextStyle(color: Colors.white))
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                final tag = await openDialog();
                setState(() {
                  this.tag = tag;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                shadowColor: const Color.fromARGB(255, 241, 147, 58),
              ),
              child: RichText(
                text: const TextSpan(children: [
                  WidgetSpan(
                    child: Icon(Icons.add, color: Colors.white, size: 15),
                  ),
                  TextSpan(text: "TAG", style: TextStyle(color: Colors.white))
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                shadowColor: const Color.fromARGB(255, 241, 147, 58),
              ),
              child: RichText(
                text: const TextSpan(children: [
                  WidgetSpan(
                    child: Icon(Icons.add, color: Colors.white, size: 15),
                  ),
                  TextSpan(
                      text: "Ingredientes",
                      style: TextStyle(color: Colors.white))
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Tempo de Preparo",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 105, 105, 105)),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: inputrecipetime,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "em minutos"),
              onSaved: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Modo de Preparo",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 105, 105, 105)),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: inputrecipepreparations,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Digite o modo de preparo da receita"),
              onSaved: (value) {},
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  shadowColor: const Color.fromARGB(255, 241, 147, 58),
                ),
                child: const Text(
                  "Pronto!",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );


  }
}

