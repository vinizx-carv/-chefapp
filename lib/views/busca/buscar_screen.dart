import 'package:chefapp/controllers/search_store.dart';
import 'package:chefapp/core/constants/enums.dart';
import 'package:chefapp/core/http/http_client.dart';
import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:chefapp/views/busca/widget/search_header.dart';
import 'package:chefapp/views/busca/widget/search_results.dart';
import 'package:chefapp/views/receita/recipe_details_page.dart';
import 'package:chefapp/views/shared/receita_card.dart';
import 'package:flutter/material.dart';

class TelaBuscar extends StatefulWidget {
  final String? initialQuery;
  final SearchType? initialType;

  const TelaBuscar({
    super.key,
    this.initialQuery,
    this.initialType,
  });

  @override
  State<TelaBuscar> createState() => _TelaBuscarState();
}

class _TelaBuscarState extends State<TelaBuscar> {

  late final TextEditingController _searchController;
  late SearchType _selectedType;

  final searchStore = SearchStore(
    repository: MealRepositoryImpl(
      client: HttpClientImpl(),
    ),
  );

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(
      text: widget.initialQuery,
    );

    _selectedType = widget.initialType ?? SearchType.category;

    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      searchStore.search(_selectedType, widget.initialQuery!);
    }
  }

  @override
  void didUpdateWidget(TelaBuscar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialQuery != oldWidget.initialQuery &&
        widget.initialQuery != null &&
        widget.initialQuery!.isNotEmpty) {

      _searchController.text = widget.initialQuery!;
      _selectedType = widget.initialType ?? SearchType.category;
      searchStore.search(_selectedType, widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    if (_searchController.text.isEmpty) return;
    searchStore.search(_selectedType, _searchController.text);
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        SearchHeader(
          controller: _searchController,
          selectedType: _selectedType,
          onSearch: _onSearch,
          onTypeChanged: (type) => setState(() => _selectedType = type),
        ),
        Expanded(
          child: SearchResults(store: searchStore),
        ),
      ],
    ),
  );
}
}