import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class TelasSempreLigadaWidget extends StatefulWidget {
  const TelasSempreLigadaWidget({super.key});

  @override
  State<TelasSempreLigadaWidget> createState() => _TelasSempreLigadaWidgetState();
}

class _TelasSempreLigadaWidgetState extends State<TelasSempreLigadaWidget> {
  bool _ativo = false;

  void _toggle(bool value) {
    setState(() => _ativo = value);
    WakelockPlus.toggle(enable: value);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Modo Cozinha',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _ativo ? Colors.green : colorScheme.outline,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _ativo ? 'Ativo' : 'Inativo',
                    style: TextStyle(
                      fontSize: 13,
                      color: _ativo ? Colors.green : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Switch(
          value: _ativo,
          onChanged: _toggle,
          activeColor: Colors.green,
        ),
      ],
      ),
    );
  }
}