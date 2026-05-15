import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {

  final IconData icon;
  final String value;
  final String label;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(

      child: Container(

        padding: const EdgeInsets.symmetric(
          vertical: 18,
        ),

        decoration: BoxDecoration(

          color: const Color.fromARGB(255, 245, 212, 189),

          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(

          children: [

            Icon(
              icon,
              size: 28,
              color: const Color(0xFFEC5C04),
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}