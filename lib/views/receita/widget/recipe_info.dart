import 'package:flutter/material.dart';

import '../../../models/meal_model.dart';


class RecipeInfo extends StatelessWidget {

  final MealModel receita;

  const RecipeInfo({
    super.key, 
    required this.receita
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [_tag('Massa'), const SizedBox(width: 10), _tag('Fácil')],
          ),

          const SizedBox(height: 16),

          Text(
            receita.name,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          const Row(
            children: [
              Icon(Icons.star, color: Colors.orange),

              SizedBox(width: 4),

              Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

      decoration: BoxDecoration(
        color: const Color(0xFFFFE8D9),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFEC5C04),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
