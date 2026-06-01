import 'package:flutter/material.dart';

import '../theme/prime_tokens.dart';

/// Dropdown com label acima, estilo consistente com PrimeTextField.
class PrimeDropdownField<T> extends StatelessWidget {
  /// Cria um dropdown com label acima do campo.
  const PrimeDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
  });

  /// Rótulo exibido acima do campo; oculto quando vazio.
  final String label;

  /// Valor atualmente selecionado.
  final T? value;

  /// Opções disponíveis no dropdown.
  final List<DropdownMenuItem<T>> items;

  /// Callback chamado quando a seleção muda.
  final ValueChanged<T?> onChanged;

  /// Texto de placeholder exibido quando nada está selecionado.
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: PrimeSpacing.sm),
        ],
        DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: true,
          items: items,
          onChanged: onChanged,
          hint: hint == null ? null : Text(hint!),
        ),
      ],
    );
  }
}
