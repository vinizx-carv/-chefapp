import 'package:flutter/material.dart';
import 'package:chefapp/views/receita/widget/stat_card.dart';

class RecipeStats extends StatelessWidget {

  const RecipeStats({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),

      child: Row(

        children: const [

          StatCard(
            icon: Icons.access_time,
            value: '30 min',
            label: 'Tempo',
          ),

          SizedBox(width: 12),

          StatCard(
            icon: Icons.local_fire_department,
            value: '520',
            label: 'Kcal',
          ),

          SizedBox(width: 12),

          StatCard(
            icon: Icons.restaurant,
            value: 'Fácil',
            label: 'Nível',
          ),
        ],
      ),
    );
  }
}