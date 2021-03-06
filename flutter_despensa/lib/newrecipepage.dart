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
  late TextEditingController inputrecipename;
  late TextEditingController inputrecipetime;
  late TextEditingController inputrecipepreparations;
  late TextEditingController inputrecipetag;
  late TextEditingController inputreciperating;

  List<String> taglist = [];
  List<String> inglist = [];

  var api_service = ApiServices();

  addRecipe(name, time, tags, ingredients, preparation, classification) async {
    var recipe = Recipe(
      id: 0,
      name: name,
      time: time,
      tags: tags,
      ingredients: ingredients,
      preparation: preparation,
      classification: classification,
      picture: '');

    await api_service.registerRecipe(recipe);
  }

  @override
  void initState() {
    super.initState();

    inputrecipename = TextEditingController();
    inputrecipetime = TextEditingController();
    inputrecipepreparations = TextEditingController();
    inputrecipetag = TextEditingController();
    inputreciperating = TextEditingController();
  }

  @override
  void dispose() {
    inputrecipetag.dispose();

    super.dispose();
  }

  void addIngredient() {
    setState(() {});
  }

  void addTag() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => RecipeListPage())));
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
              key: const Key("Name"),
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
            Container(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    key: const Key("TAG"),
                    onPressed: () async {
                      final tag = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  "Inclua uma TAG",
                                  style: TextStyle(color: Colors.orangeAccent),
                                ),
                                content: TextField(
                                  key: const Key("WriteTAG"),
                                  controller: inputrecipetag,
                                  decoration: const InputDecoration(
                                      hintText: "pr??tica, caf??, r??pida..."),
                                ),
                                actions: [
                                  TextButton(
                                      key: const Key("AddTAG"),
                                      autofocus: true,
                                      child: const Text("ADICIONAR"),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(inputrecipetag.text);
                                      })
                                ],
                              ));
                      setState(() {
                        taglist.add(tag);
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
                        TextSpan(
                            text: "TAG", style: TextStyle(color: Colors.white))
                      ]),
                    ),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: taglist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 35,
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.all(3),
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 248, 190, 114),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(taglist[index],
                                style: const TextStyle(color: Colors.white)),
                          ),
                        );
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    key: const Key("Ingredient"),
                    onPressed: () async {
                      final ing = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  "Inclua um Ingrediente",
                                  style: TextStyle(color: Colors.orangeAccent),
                                ),
                                content: TextField(
                                  key: const Key("WriteIngredient"),
                                  controller: inputrecipetag,
                                  decoration: const InputDecoration(
                                      hintText: "2 ovos, 1 x??cara de leite..."),
                                ),
                                actions: [
                                  TextButton(
                                      key: const Key("AddIngredient"),
                                      autofocus: true,
                                      child: const Text("ADICIONAR"),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(inputrecipetag.text);
                                      })
                                ],
                              ));
                      setState(() {
                        inglist.add(ing);
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
                        TextSpan(
                            text: "Ingrediente",
                            style: TextStyle(color: Colors.white))
                      ]),
                    ),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: taglist.length,
                      itemBuilder: (BuildContext context2, int index) {
                        if (inglist.isEmpty) {
                          return const SizedBox(
                            height: 1,
                            width: 1,
                          );
                        } else {
                          return Container(
                            height: 35,
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 248, 190, 114),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(inglist[index],
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          );
                        }
                      }),
                ],
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
              key: const Key("Time"),
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
              key: const Key("Preparation"),
              controller: inputrecipepreparations,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Digite o modo de preparo da receita"),
              onSaved: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Classifica????o",
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
              key: const Key("Rating"),
              controller: inputreciperating,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Digite a classifica????o da receita (0 - 5)"),
              onSaved: (value) {},
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                key: const Key("AddRecipe"),
                onPressed: () async {
                  await addRecipe(inputrecipename.value.text, int.parse(inputrecipetime.value.text), taglist,
                      inglist, inputrecipepreparations.value.text, double.parse(inputreciperating.value.text));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => RecipeListPage())));
                },
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
