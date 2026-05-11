import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:flutter/material.dart';
import 'package:chefapp/core/http/http_client.dart';
import 'package:chefapp/controllers/category_store.dart';
import 'package:chefapp/models/category_model.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final categoryStore = CategoryStore(
    repository: MealRepositoryImpl(
      client: HttpClientImpl(),
    ),
  );

  @override
  void initState() {
    super.initState();
    categoryStore.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          // header - não muda nada aqui
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
                  const SizedBox(height: 30),
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
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                        hintText: 'Buscar receitas ou ingredientes...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // lista de categorias
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: categoryStore.isLoading,
              builder: (context, isLoading, _) {

                // carregando
                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // erro
                if (categoryStore.error.value.isNotEmpty) {
                  return Center(
                    child: Text(categoryStore.error.value),
                  );
                }

                // sucesso
                return ValueListenableBuilder(
                  valueListenable: categoryStore.categories,
                  builder: (context, categories, _) {
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          leading: Image.network(category.image),
                          title: Text(category.name),
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