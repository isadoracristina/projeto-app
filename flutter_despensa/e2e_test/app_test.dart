import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_despensa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Search for a recipe by ingredient", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("Initialize")));
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key("User")), "admin");
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("Password")), "0000");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key("Enter")));
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5));
    await tester.tap(find.byKey(const Key("RecipeList")));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key("FilterRecipes")));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5));
    await tester.enterText(find.byKey(const Key("Ingredients")), "Arroz");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));
    await tester.tap(find.byKey(const Key("Filter")));
    await tester.pumpAndSettle();

    expect(find.text("Arroz"), findsOneWidget);

    await Future.delayed(const Duration(seconds: 5));
    await tester.tap(find.text("Arroz"));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5));
    expect(find.text("Arroz"), findsOneWidget);
    expect(find.text("Acompanhamento"), findsOneWidget);
    expect(find.text("40 min"), findsOneWidget);
    
  });

  testWidgets("Add a new Recipe", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("Initialize")));
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key("User")), "admin");
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("Password")), "0000");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key("Enter")));
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5));
    await tester.tap(find.byKey(const Key("RecipeList")));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key("AddRecipe")));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3));
    await tester.enterText(find.byKey(const Key("Name")), "Gelo");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key("TAG")));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.enterText(find.byKey(const Key("WriteTAG")), "Prática");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key("AddTAG")));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key("Ingredient")));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.enterText(find.byKey(const Key("WriteIngredient")), "Água");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key("AddIngredient")));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3));
    await tester.enterText(find.byKey(const Key("Time")), "60");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3));
    await tester.enterText(find.byKey(const Key("Preparation")), "Coloque a água na forma dentro do congelador. Espere 1 hora");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3));
    await tester.enterText(find.byKey(const Key("Rating")), "5");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key("AddRecipe")));
    await tester.pumpAndSettle();

    expect(find.text("Gelo"), findsOneWidget);

    await Future.delayed(const Duration(seconds: 5));
    await tester.tap(find.text("Gelo"));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5));
    expect(find.text("Coloque a água na forma dentro do congelador. Espere 1 hora"), findsOneWidget);

    

  });

}