import 'package:flutter/material.dart';
import 'package:chefapp/core/database/database_service.dart';

class NotesStore {
  final DatabaseService databaseService;

  NotesStore({required this.databaseService});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<String> nota = ValueNotifier('');
  final ValueNotifier<Map<int, bool>> progresso = ValueNotifier({});

  // busca a anotação e o progresso da receita
  Future<void> load(String mealId) async {
    isLoading.value = true;

    try {
      final anotacao = await databaseService.buscarAnotacao(mealId);
      nota.value = anotacao ?? '';

      progresso.value = await databaseService.buscarProgresso(mealId);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // salva a anotação
  Future<void> salvarNota(String mealId, String texto) async {
    try {
      await databaseService.salvarAnotacao(mealId, texto);
      nota.value = texto;
    } catch (e) {
      error.value = e.toString();
    }
  }

  // salva o progresso de um passo
  Future<void> salvarProgresso(String mealId, int step, bool isDone) async {
    try {
      await databaseService.salvarProgresso(mealId, step, isDone);
      progresso.value = {
        ...progresso.value,
        step: isDone,
      };
    } catch (e) {
      error.value = e.toString();
    }
  }
}