import 'package:flutter/material.dart';

import 'package:chefapp/models/meal_model.dart';

import 'package:chefapp/views/receita/widget/instruction_step_card.dart';

class InstructionsSection extends StatelessWidget {

  final MealModel receita;

  const InstructionsSection({
    super.key,
    required this.receita,
  });

  @override
  Widget build(BuildContext context) {

    final steps = receita.instructions
        .split('.')
        .where((e) => e.trim().isNotEmpty)
        .toList();

    return Padding(

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      child: Column(

        children: List.generate(

          steps.length,

          (index) {

            return InstructionStepCard(

              step: index + 1,

              text: steps[index].trim(),
            );
          },
        ),
      ),
    );
  }
}