import 'package:flutter/material.dart';
import 'package:flutter_despensa/recipelistpage.dart';
import 'main.dart';
import 'recipelistpage.dart';

class UserPage extends StatefulWidget {

  String name;

  UserPage(this.name);
  
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 147, 58),
        title: const Text('Olá,',
          style: TextStyle(
            fontWeight: FontWeight.bold
            ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                    HomePage(),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),            
            Text(widget.name,
            textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color.fromARGB(255, 241, 147, 58),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/myrecipes.jpg',
                    height: 200,
                    width: 300,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => RecipeListPage()
                        )
                      )
                    );
                  },
                  child: const Text('Minhas\nReceitas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  )
                ) 
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                shadowColor: const Color.fromARGB(255, 241, 147, 58),
              ),
              child: const Text(
                'Meus últimos Pratos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/mystock.jpg',
                    height: 200,
                    width: 300,
                  ),
                ),
                const Text('Minha\nDespensa',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                )
              ],
            ),



          ]
        ),      
      )
    );
  }
}