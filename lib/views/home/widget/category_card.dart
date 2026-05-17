import 'package:flutter/material.dart';

import '../../../models/category_model.dart';

class CategoryCard extends StatelessWidget {

  final CategoryModel category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 95,

      margin: const EdgeInsets.only(
        right: 18,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center,

        children: [

          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(
                    0.08,
                  ),

                  blurRadius: 12,

                  offset: const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),

            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(50),

              child: SizedBox(
                width: 82,
                height: 82,

                child: Image.network(
                  category.image,

                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            category.name,

            maxLines: 1,

            overflow:
                TextOverflow.ellipsis,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}