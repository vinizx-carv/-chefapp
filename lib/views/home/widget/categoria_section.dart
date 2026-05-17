import 'package:chefapp/controllers/category_store.dart';
import 'package:chefapp/core/constants/enums.dart';
import 'package:chefapp/views/home/widget/category_card.dart';
import 'package:flutter/material.dart';
// views/home/widgets/categorias_section.dart

class CategoriasSection extends StatelessWidget {
  final CategoryStore store;
  final Function(String query, {SearchType type}) onSearch;

  const CategoriasSection({
    super.key,
    required this.store,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 15),
          child: Text(
            'Categorias',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: store.isLoading,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (store.error.value.isNotEmpty) {
              return Center(child: Text(store.error.value));
            }

            return ValueListenableBuilder(
              valueListenable: store.categories,
              builder: (context, categories, _) {
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return GestureDetector(
                        onTap: () => onSearch(
                          category.name,
                          type: SearchType.category,
                        ),
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
    );
  }
}