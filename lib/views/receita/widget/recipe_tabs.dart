import 'package:chefapp/controllers/notes_store.dart';
import 'package:flutter/material.dart';
import 'package:chefapp/models/meal_model.dart';
import 'package:chefapp/views/receita/widget/recipe_ingredient.dart';
import 'package:chefapp/views/receita/widget/instruction_section.dart';

class RecipeTabs extends StatefulWidget {

  final MealModel receita;
  final NotesStore notesStore;

  const RecipeTabs({
    super.key,
    required this.receita,
    required this.notesStore,
  });

  @override
  State<RecipeTabs> createState() => _RecipeTabsState();
}

class _RecipeTabsState extends State<RecipeTabs> {

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF1E9E2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedTab = 0);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: selectedTab == 0
                          ? const Color(0xFFEC5C04)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Ingredientes',
                        style: TextStyle(
                          color: selectedTab == 0
                              ? Colors.white
                              : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedTab = 1);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: selectedTab == 1
                          ? const Color(0xFFEC5C04)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Modo de preparo',
                        style: TextStyle(
                          color: selectedTab == 1
                              ? Colors.white
                              : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        if (selectedTab == 0)
          IngredientsSection(receita: widget.receita)
        else
          InstructionsSection(
            receita: widget.receita,
            notesStore: widget.notesStore,
          ),
      ],
    );
  }
}