import 'package:chefapp/core/constants/enums.dart';
import 'package:chefapp/core/http/http_client.dart';
import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:chefapp/controllers/category_store.dart';
import 'package:chefapp/views/home/widget/categorias.dart';
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

  @override
  void initState() {
    super.initState();
    categoryStore.getCategories();
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
      body: Column(
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

                        style: TextStyle(color: Colors.white70, fontSize: 16),
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

              // IMAGEM
              Positioned(
                bottom: -150,
                left: 0,
                right: 0,

                child: Center(
                  child: Container(
                    width: 370,
                    height: 170,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      image: const DecorationImage(
                        image: NetworkImage('https://picsum.photos/300'),
                        fit: BoxFit.cover,
                      ),

                      boxShadow: const [
                        BoxShadow(blurRadius: 10, color: Colors.black26),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // espaço da imagem
          const SizedBox(height: 160),

          // CATEGORIAS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Padding(
                padding: EdgeInsets.only(left: 13, bottom: 15),

                child: Text(
                  'Categorias',

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        ],
      ),
    );
  }
}
