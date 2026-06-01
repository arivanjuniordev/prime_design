import 'package:flutter/material.dart';

import '../theme/prime_tokens.dart';

/// Dropdown com label acima, estilo consistente com PrimeTextField.
class PrimeDropdownField<T> extends StatelessWidget {
  const PrimeDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
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
