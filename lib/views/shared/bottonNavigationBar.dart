import 'package:chefapp/core/constants/enums.dart';
import 'package:flutter/material.dart';
import '../busca/buscar_screen.dart';
import '../favorits/favorits_screen.dart';
import '../home/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int paginaAtual = 0;
  String? _searchQuery;
  SearchType? _searchType;

  void _navigateToSearch(String query, {SearchType type = SearchType.name}) {
    setState(() {
      _searchQuery = query;
      _searchType = type;
      paginaAtual = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: paginaAtual,
        children: [
          TelaHome(onSearch: _navigateToSearch),
          TelaBuscar(
            key: ValueKey(_searchQuery ?? ''),
            initialQuery: _searchQuery,
            initialType: _searchType,
          ),
          const TelaFavorito(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        selectedItemColor: const Color(0xFFEC5C04),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            paginaAtual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorito',
          ),
        ],
      ),
    );
  }
}
