import 'package:chefapp/controllers/random_meal_store.dart';
import 'package:flutter/material.dart';

class DestaqueHeroCard extends StatelessWidget {
  final RandomMealStore store;

  const DestaqueHeroCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: store.meals,
      builder: (context, meals, _) {
        final image = meals.isNotEmpty
            ? meals.first.image
            : 'https://4kwallpapers.com/images/walls/thumbs_3t/24150.jpg';
        final name = meals.isNotEmpty ? meals.first.name : 'Carregando...';

        return Center(
          child: Container(
            width: 370,
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
              boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
            child: Stack(
              children: [
                // gradiente escuro embaixo
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                // badge "EM DESTAQUE"
                Positioned(
                  top: 12, left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                // nome + infos
                Positioned(
                  bottom: 12, left: 14, right: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Color(0xFFFFD700), size: 15),
                          SizedBox(width: 3),
                          Text('4.9', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                          SizedBox(width: 14),
                          Icon(Icons.access_time, color: Colors.white70, size: 15),
                          SizedBox(width: 3),
                          Text('20 min', style: TextStyle(color: Colors.white70, fontSize: 13)),
                          SizedBox(width: 14),
                          Icon(Icons.local_fire_department, color: Colors.white70, size: 15),
                          SizedBox(width: 3),
                          Text('490 kcal', style: TextStyle(color: Colors.white70, fontSize: 13)),
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
    );
  }
}