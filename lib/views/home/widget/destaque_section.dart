import 'package:chefapp/controllers/random_meal_store.dart';
import 'package:chefapp/models/meal_summary_model.dart';
import 'package:chefapp/views/receita/recipe_details_page.dart';
import 'package:chefapp/views/shared/receita_card.dart';
import 'package:flutter/material.dart';


class DestaqueSection extends StatelessWidget {
  final RandomMealStore store;

  const DestaqueSection({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 13, bottom: 15),
          child: Text(
            'Destaques',
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
                    return ReceitaCard(
                      receita: MealSummaryModel(
                        id: meal.id,
                        name: meal.name,
                        image: meal.image,
                      ),
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