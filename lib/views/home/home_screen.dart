import 'package:flutter/material.dart';
import '../../core/services/receita_mock_service.dart';
import '../shared/receita_card.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  @override
  Widget build(BuildContext context) {

    final receitas = ReceitaMockService.buscarReceitas();

    return Scaffold(

      body: Column(
      
        children: [
        
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
                  
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

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

          Expanded(
          
            child: ListView(
              children: const [],
            ),
          ),
        ],
      ),
    );
  }
}