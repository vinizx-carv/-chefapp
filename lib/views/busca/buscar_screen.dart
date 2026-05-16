import 'package:chefapp/controllers/favorites_store.dart';
import 'package:chefapp/controllers/search_store.dart';
import 'package:chefapp/core/constants/enums.dart';
import 'package:chefapp/core/database/database_service.dart';
import 'package:chefapp/core/http/http_client.dart';
import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:chefapp/views/receita/recipe_details_page.dart';
import 'package:chefapp/views/shared/receita_card.dart';
import 'package:flutter/material.dart';

class TelaBuscar extends StatefulWidget {
  final String? initialQuery;
  final SearchType? initialType;

  const TelaBuscar({
    super.key,
    this.initialQuery,
    this.initialType,
  });

  @override
  State<TelaBuscar> createState() => _TelaBuscarState();
}

class _TelaBuscarState extends State<TelaBuscar> {

  late final TextEditingController _searchController;
  late SearchType _selectedType;

  final searchStore = SearchStore(
    repository: MealRepositoryImpl(
      client: HttpClientImpl(),
    ),
  );

  final favoritesStore = FavoritesStore(
    databaseService: DatabaseService(),
  );

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(
      text: widget.initialQuery,
    );

    _selectedType = widget.initialType ?? SearchType.name;

    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      searchStore.search(_selectedType, widget.initialQuery!);
    }
  }

  @override
  void didUpdateWidget(TelaBuscar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialQuery != oldWidget.initialQuery &&
        widget.initialQuery != null &&
        widget.initialQuery!.isNotEmpty) {

      _searchController.text = widget.initialQuery!;
      _selectedType = widget.initialType ?? SearchType.name;
      searchStore.search(_selectedType, widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    if (_searchController.text.isEmpty) return;
    searchStore.search(_selectedType, _searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFEC5C04),
            child: SafeArea(
              child: Column(
                children: [

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
                        hintText: 'Buscar...',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: _onSearch,
                        ),
                      ),
                      onSubmitted: (_) => _onSearch(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRadio('Nome', SearchType.name),
                      _buildRadio('Ingrediente', SearchType.ingredient),
                      _buildRadio('Categoria', SearchType.category),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: searchStore.isLoading,
              builder: (context, isLoading, _) {

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (searchStore.error.value.isNotEmpty) {
                  return Center(child: Text(searchStore.error.value));
                }

                return ValueListenableBuilder(
                  valueListenable: searchStore.meals,
                  builder: (context, meals, _) {

                    if (meals.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma receita encontrada'),
                      );
                    }

                    return ListView.builder(
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        final meal = meals[index];

                        return ValueListenableBuilder(
                          valueListenable: favoritesStore.isFavorite,
                          builder: (context, _, __) {

                            return FutureBuilder<bool>(
                              future: DatabaseService().isFavorite(meal.id),
                              builder: (context, snapshot) {
                                final isFav = snapshot.data ?? false;

                                return ReceitaCard(
                                  receita: meal,
                                  isFavorite: isFav,
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
                                    setState(() {});
                                  },
                                );
                              },
                            );
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

  Widget _buildRadio(String label, SearchType type) {
    return Row(
      children: [
        Radio<SearchType>(
          value: type,
          groupValue: _selectedType,
          activeColor: Colors.white,
          onChanged: (value) {
            setState(() => _selectedType = value!);
          },
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}