import 'package:chefapp/controllers/notes_store.dart';
import 'package:flutter/material.dart';

class InstructionStepCard extends StatefulWidget {

  final int step;
  final String text;
  final String mealId;
  final NotesStore notesStore;

  const InstructionStepCard({
    super.key,
    required this.step,
    required this.text,
    required this.mealId,
    required this.notesStore,
  });

  @override
  State<InstructionStepCard> createState() => _InstructionStepCardState();
}

class _InstructionStepCardState extends State<InstructionStepCard> {

  bool isDone = false;

  @override
  void initState() {
    super.initState();
    // carrega o progresso salvo
    isDone = widget.notesStore.progresso.value[widget.step] ?? false;

    // escuta mudanças no progresso
    widget.notesStore.progresso.addListener(_onProgressoChanged);
  }

  @override
  void dispose() {
    widget.notesStore.progresso.removeListener(_onProgressoChanged);
    super.dispose();
  }

  void _onProgressoChanged() {
    setState(() {
      isDone = widget.notesStore.progresso.value[widget.step] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8DDD4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isDone,
            activeColor: const Color(0xFFEC5C04),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onChanged: (value) {
              widget.notesStore.salvarProgresso(
                widget.mealId,
                widget.step,
                value!,
              );
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PASSO ${widget.step}',
                  style: const TextStyle(
                    color: Color(0xFFEC5C04),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: isDone ? Colors.grey : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}