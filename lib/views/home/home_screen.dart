import 'package:flutter/material.dart';
import '../../controllers/home_controller.dart';
import './widget/meal_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = HomeController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receitas')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return Column(
            children: [
              // 🔍 BUSCA
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Buscar receita...",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.search(searchController.text);
                      },
                    ),
                  ),
                ),
              ),

              if (controller.isLoading)
                const CircularProgressIndicator(),


              Expanded(
                child: ListView.builder(
                  itemCount: controller.meals.length,
                  itemBuilder: (_, i) {
                    final meal = controller.meals[i];

                    return MealListItem(
                      meal: meal,
                      onTap: () {
                        // navegação futura
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}