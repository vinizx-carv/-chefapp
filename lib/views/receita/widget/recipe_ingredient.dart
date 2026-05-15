import 'package:flutter/material.dart';
import 'package:chefapp/models/meal_model.dart';

class IngredientsSection extends StatelessWidget {

  final MealModel receita;

  const IngredientsSection({
    super.key,
    required this.receita,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            'Ingredientes',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ListView.builder(

            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),

            itemCount: receita.ingredients.length,

            itemBuilder: (context, index) {

              final ingredient = receita.ingredients[index];

              final measure = index < receita.measures.length
                  ? receita.measures[index]
                  : '';

              return Container(

                margin: const EdgeInsets.only(bottom: 12),

                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                    color: const Color.fromARGB(255, 155, 154, 154),
                    width: 1,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Row(

                  children: [

                    Container(

                      width: 10,
                      height: 10,

                      decoration: const BoxDecoration(
                        color: Color(0xFFEC5C04),
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(

                      child: Text(
                        ingredient,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Text(
                      measure,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}