import 'package:flutter/material.dart';
import '../../../models/meal_model.dart';

class RecipeHeader extends StatelessWidget {
  final MealModel receita;

  const RecipeHeader({super.key, required this.receita});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.network(
            receita.image,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(154, 13, 13, 13),
              child: IconButton(
                color: Color.fromARGB(255, 255, 255, 255),
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
