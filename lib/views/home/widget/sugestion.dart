import 'package:chefapp/controllers/random_meal_store.dart';
import 'package:chefapp/views/home/widget/random_meal_card.dart';
import 'package:chefapp/views/receita/recipe_details_page.dart';
import 'package:flutter/material.dart';


class SugestoesSection extends StatelessWidget {
  final RandomMealStore store;

  const SugestoesSection({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 0),
          child: Text(
            'Sugestões para você',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ValueListenableBuilder(
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
                if (meals.isEmpty) return const SizedBox();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return RandomMealCard(
                      meal: meal,
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
        ),
      ],
    );
  }
}