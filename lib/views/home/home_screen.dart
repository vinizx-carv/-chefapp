import 'package:chefapp/controllers/category_store.dart';
import 'package:chefapp/controllers/random_meal_store.dart';
import 'package:chefapp/core/constants/enums.dart';
import 'package:chefapp/core/http/http_client.dart';
import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:chefapp/models/meal_summary_model.dart';
import 'package:chefapp/views/home/widget/categorias.dart';
import 'package:chefapp/views/home/widget/random_meal_card.dart';
import 'package:chefapp/views/receita/recipe_details_page.dart';
import 'package:chefapp/views/shared/receita_card.dart';
import 'package:flutter/material.dart';

class TelaHome extends StatefulWidget {
  final Function(String query, {SearchType type}) onSearch;

  const TelaHome({super.key, required this.onSearch});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final _searchController = TextEditingController();

  final categoryStore = CategoryStore(
    repository: MealRepositoryImpl(client: HttpClientImpl()),
  );

  final randomMealStore = RandomMealStore(
    repository: MealRepositoryImpl(client: HttpClientImpl()),
  );

  final destaqueStore = RandomMealStore(
    repository: MealRepositoryImpl(client: HttpClientImpl()),
  );

  Future<void> _refreshPage() async {
    await Future.wait([
      categoryStore.getCategories(),
      randomMealStore.getRandomMeals(2),
      destaqueStore.getRandomMeals(4),
    ]);
  }

  @override
  void initState() {
    super.initState();
    categoryStore.getCategories();
    randomMealStore.getRandomMeals(2);
    destaqueStore.getRandomMeals(4);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToSearch() {
    if (_searchController.text.isEmpty) return;
    widget.onSearch(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: const Color(0xFFFA4A0C),
        backgroundColor: Colors.white,
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFEC5C04), Color(0xFFFF7A00)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white24,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.restaurant,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white24,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.notifications_none,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'O que vamos\ncozinhar hoje?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Explore mais de 300 receitas incríveis',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: TextField(
                              controller: _searchController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: const Icon(Icons.search),
                                hintText: 'Buscar receitas ou ingredientes...',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: _navigateToSearch,
                                ),
                              ),
                              onSubmitted: (_) => _navigateToSearch(),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -150,
                    left: 0,
                    right: 0,
                    child: ValueListenableBuilder(
                      valueListenable: destaqueStore.meals,
                      builder: (context, meals, _) {
                        final destaque = meals.isNotEmpty ? meals.first : null;
                        return Center(
                          child: Container(
                            width: 370,
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  destaqueStore.meals.value.isNotEmpty
                                      ? destaqueStore.meals.value.first.image
                                      : 'https://4kwallpapers.com/images/walls/thumbs_3t/24150.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.75),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF7A00),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'EM DESTAQUE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 12,
                                  left: 14,
                                  right: 14,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        destaqueStore.meals.value.isNotEmpty
                                            ? destaqueStore
                                                  .meals
                                                  .value
                                                  .first
                                                  .name
                                            : 'Carregando...',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      const SizedBox(height: 6),

                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xFFFFD700),
                                            size: 15,
                                          ),
                                          const SizedBox(width: 3),
                                          const Text(
                                            '4.9',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                          const SizedBox(width: 14),

                                          const Icon(
                                            Icons.access_time,
                                            color: Colors.white70,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 3),
                                          const Text(
                                            '20 min',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                            ),
                                          ),

                                          const SizedBox(width: 14),

                                          const Icon(
                                            Icons.local_fire_department,
                                            color: Colors.white70,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 3),
                                          const Text(
                                            '490 kcal',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 160),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 15),
                    child: Text(
                      'Categorias',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ValueListenableBuilder(
                    valueListenable: categoryStore.isLoading,
                    builder: (context, isLoading, _) {
                      if (isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (categoryStore.error.value.isNotEmpty) {
                        return Center(child: Text(categoryStore.error.value));
                      }

                      return ValueListenableBuilder(
                        valueListenable: categoryStore.categories,
                        builder: (context, categories, _) {
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return GestureDetector(
                                  onTap: () {
                                    widget.onSearch(
                                      category.name,
                                      type: SearchType.category,
                                    );
                                  },
                                  child: CategoryCard(category: category),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 0),
                    child: Text(
                      'Sugestões para você',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ValueListenableBuilder(
                    valueListenable: randomMealStore.isLoading,
                    builder: (context, isLoading, _) {
                      if (isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (randomMealStore.error.value.isNotEmpty) {
                        return Center(child: Text(randomMealStore.error.value));
                      }

                      return ValueListenableBuilder(
                        valueListenable: randomMealStore.meals,
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
                                      builder: (_) =>
                                          RecipeDetailsPage(mealId: meal.id),
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
              ),

              const SizedBox(height: 24),

              // destaques
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 13, bottom: 15),
                    child: Text(
                      'Destaques',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ValueListenableBuilder(
                    valueListenable: destaqueStore.isLoading,
                    builder: (context, isLoading, _) {
                      if (isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (destaqueStore.error.value.isNotEmpty) {
                        return Center(child: Text(destaqueStore.error.value));
                      }

                      return ValueListenableBuilder(
                        valueListenable: destaqueStore.meals,
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
                                      builder: (_) =>
                                          RecipeDetailsPage(mealId: meal.id),
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
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
