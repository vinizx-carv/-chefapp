import 'package:chefapp/controllers/search_store.dart';
import 'package:chefapp/views/receita/recipe_details_page.dart';
import 'package:chefapp/views/shared/receita_card.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  final SearchStore store;

  const SearchResults({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: store.isLoading,
      builder: (context, isLoading, _) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (store.error.value.isNotEmpty) {
          return Center(child: Text(store.error.value));
        }

        return ValueListenableBuilder(
          valueListenable: store.meals,
          builder: (context, meals, _) {
            if (meals.isEmpty) {
              return const Center(child: Text('Nenhuma receita encontrada'));
            }

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return ReceitaCard(
                  receita: meal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailsPage(mealId: meal.id),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
