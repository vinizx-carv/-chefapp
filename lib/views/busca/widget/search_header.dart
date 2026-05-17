// views/buscar/widgets/search_header.dart

import 'package:chefapp/core/constants/enums.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatefulWidget {
  final TextEditingController controller;
  final SearchType selectedType;
  final VoidCallback onSearch;
  final ValueChanged<SearchType> onTypeChanged;

  const SearchHeader({
    super.key,
    required this.controller,
    required this.selectedType,
    required this.onSearch,
    required this.onTypeChanged,
  });

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  late SearchType _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                controller: widget.controller,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: const Icon(Icons.search),
                  hintText: 'Buscar...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: widget.onSearch,
                  ),
                ),
                onSubmitted: (_) => widget.onSearch(),
              ),
            ),
            const SizedBox(height: 12),
            // ← OS CHIPS FICAM AQUI
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildChip('Por categoria', SearchType.category),
                _buildChip('Por ingrediente', SearchType.ingredient),
                _buildChip('Por nome', SearchType.name),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ← E O MÉTODO AQUI DENTRO DA CLASSE
  Widget _buildChip(String label, SearchType type) {
    final isSelected = _selectedType == type;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedType = type);
        widget.onTypeChanged(type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFFEC5C04) : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}