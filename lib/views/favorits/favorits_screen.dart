import 'package:chefapp/controllers/favorites_store.dart';
import 'package:chefapp/core/database/database_service.dart';
import 'package:chefapp/core/listeners/favorite_listener.dart';
import 'package:chefapp/core/listeners/favorite_notifier.dart';
import 'package:chefapp/views/receita/recipe_details_page.dart';
import 'package:chefapp/views/shared/receita_card.dart';
import 'package:flutter/material.dart';

class TelaFavorito extends StatefulWidget {
  const TelaFavorito({super.key});

  @override
  State<TelaFavorito> createState() => _TelaFavoritoState();
}

class _TelaFavoritoState extends State<TelaFavorito>
    implements FavoriteListener {

  final favoritesStore = FavoritesStore(
    databaseService: DatabaseService(),
  );

  @override
  void initState() {
    super.initState();
    favoritesStore.getFavorites();
    FavoriteNotifier().addListener(this);
  }

  @override
  void dispose() {
    FavoriteNotifier().removeListener(this);
    super.dispose();
  }

  @override
  void onFavoriteChanged() {
    favoritesStore.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFEC5C04),
                  Color(0xFFFF7A00),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const SafeArea(
              child: Text(
                'Favoritos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: favoritesStore.isLoading,
              builder: (context, isLoading, _) {

                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (favoritesStore.error.value.isNotEmpty) {
                  return Center(
                    child: Text(favoritesStore.error.value),
                  );
                }

                return ValueListenableBuilder(
                  valueListenable: favoritesStore.favorites,
                  builder: (context, favorites, _) {

                    if (favorites.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_border,
                              size: 80,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Nenhuma receita favorita ainda',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final meal = favorites[index];

                        return ReceitaCard(
                          receita: meal,
                          isFavorite: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RecipeDetailsPage(
                                  mealId: meal.id,
                                ),
                              ),
                            );
                          },
                          onFavoriteTap: () async {
                            await favoritesStore.toggleFavorite(meal);
                            FavoriteNotifier().notify();
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}