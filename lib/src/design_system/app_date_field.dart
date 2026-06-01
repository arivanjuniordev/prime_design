import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/design_tokens.dart';

/// Campo de data: abre showDatePicker ao tocar. Mostra dd/MM/yyyy.
class AppDateField extends StatelessWidget {
  const AppDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  static final _fmt = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: () async {
            final now = DateTime.now();
            final picked = await showDatePicker(
              context: context,
              initialDate: value ?? now,
              firstDate: DateTime(now.year - 30),
              lastDate: DateTime(now.year + 30),
            );
            if (picked != null) onChanged(picked);
          },
          child: InputDecorator(
            decoration: InputDecoration(
              suffixIcon: value == null
                  ? const Icon(Icons.calendar_today_outlined, size: 18)
                  : IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () => onChanged(null),
                    ),
            ),
            child: Text(
              value == null ? 'Selecionar data' : _fmt.format(value!),
            ),
          ),
        ),
      ],
    );
  }
}
