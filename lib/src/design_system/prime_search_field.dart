import 'package:flutter/material.dart';

/// Campo de busca com ícone de lupa e placeholder configurável.
class PrimeSearchField extends StatelessWidget {
  /// Cria um campo de busca.
  const PrimeSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hint = 'Buscar...',
  });

  /// Controlador do texto digitado.
  final TextEditingController controller;

  /// Chamado a cada alteração do texto.
  final ValueChanged<String> onChanged;

  /// Texto de placeholder exibido quando o campo está vazio.
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search, size: 20),
      ),
    );
  }
}
