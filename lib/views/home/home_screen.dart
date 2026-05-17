import 'package:chefapp/controllers/category_store.dart';
import 'package:chefapp/controllers/random_meal_store.dart';
import 'package:chefapp/core/constants/enums.dart';
import 'package:chefapp/core/http/http_client.dart';
import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:chefapp/views/home/widget/categoria_section.dart';
import 'package:chefapp/views/home/widget/destaque_hero_card.dart';
import 'package:chefapp/views/home/widget/destaque_section.dart';
import 'package:chefapp/views/home/widget/home_header.dart';
import 'package:chefapp/views/home/widget/sugestion.dart';
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
                  HomeHeader(
                    searchController: _searchController,
                    onSearch: _navigateToSearch,
                  ),
                  Positioned(
                    bottom: -150,
                    left: 0,
                    right: 0,
                    child: DestaqueHeroCard(store: destaqueStore),
                  ),
                ],
              ),
              const SizedBox(height: 160),
              CategoriasSection(
                store: categoryStore,
                onSearch: widget.onSearch,
              ),
              SugestoesSection(store: randomMealStore),
              const SizedBox(height: 24),
              DestaqueSection(store: destaqueStore),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
