import 'package:flutter/material.dart';
import 'package:chefapp/controllers/favorites_store.dart';
import 'package:chefapp/core/database/database_service.dart';
import 'package:chefapp/core/listeners/favorite_notifier.dart';
import 'package:chefapp/models/meal_model.dart';
import 'package:chefapp/models/meal_summary_model.dart';

class RecipeHeader extends StatefulWidget {
  final MealModel receita;

  const RecipeHeader({super.key, required this.receita});

  @override
  State<RecipeHeader> createState() => _RecipeHeaderState();
}

class _RecipeHeaderState extends State<RecipeHeader> {

  final favoritesStore = FavoritesStore(
    databaseService: DatabaseService(),
  );

  @override
  void initState() {
    super.initState();
    favoritesStore.checkIsFavorite(widget.receita.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.network(
            widget.receita.image,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // botão de voltar
          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(154, 13, 13, 13),
              child: IconButton(
                color: const Color.fromARGB(255, 255, 255, 255),
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // botão de favorito
          Positioned(
            top: 50,
            right: 16,
            child: ValueListenableBuilder(
              valueListenable: favoritesStore.isFavorite,
              builder: (context, isFavorite, _) {
                return CircleAvatar(
                  backgroundColor: const Color.fromARGB(154, 13, 13, 13),
                  child: IconButton(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.orange : Colors.white,
                    ),
                    onPressed: () async {
                      await favoritesStore.toggleFavorite(
                        MealSummaryModel(
                          id:    widget.receita.id,
                          name:  widget.receita.name,
                          image: widget.receita.image,
                        ),
                      );
                      FavoriteNotifier().notify();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}