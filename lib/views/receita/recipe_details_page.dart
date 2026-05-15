import 'package:flutter/material.dart';

import 'package:chefapp/models/meal_model.dart';

import 'package:chefapp/core/http/http_client.dart';
import 'package:chefapp/core/repositories/meal_repository.dart';

import 'package:chefapp/views/receita/widget/recipe_header.dart';
import 'package:chefapp/views/receita/widget/recipe_info.dart';
import 'package:chefapp/views/receita/widget/recipe_stats.dart';
import 'package:chefapp/views/receita/widget/recipe_ingredient.dart';
import 'package:chefapp/views/receita/widget/recipe_tabs.dart';

class RecipeDetailsPage extends StatefulWidget {

  final String mealId;

  const RecipeDetailsPage({
    super.key,
    required this.mealId,
  });

  @override
  State<RecipeDetailsPage> createState() =>
      _RecipeDetailsPageState();
}

class _RecipeDetailsPageState
    extends State<RecipeDetailsPage> {

  late Future<MealModel> mealFuture;

  final repository = MealRepositoryImpl(
    client: HttpClientImpl(),
  );

  @override
  void initState() {
    super.initState();

    mealFuture =
        repository.getMealById(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF8F5F2),

      body: FutureBuilder<MealModel>(

        future: mealFuture,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return const Center(
              child: Text('Erro ao carregar receita'),
            );
          }

          if (!snapshot.hasData) {

            return const Center(
              child: Text('Receita não encontrada'),
            );
          }

          final receita = snapshot.data!;

          return SingleChildScrollView(

            child: Column(

              children: [

                RecipeHeader(receita: receita),

                RecipeInfo(receita: receita),
                const RecipeStats(),
                RecipeTabs(receita: receita),
            
              ],
            ),
          );
        },
      ),
    );
  }
}