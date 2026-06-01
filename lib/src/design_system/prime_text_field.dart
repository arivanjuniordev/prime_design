import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_tokens.dart';

/// Campo de texto com label acima. Estilo herda do inputDecorationTheme.
class PrimeTextField extends StatelessWidget {
  const PrimeTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final int? maxLength;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          // Label visual; a semântica é fornecida pelo Semantics no campo abaixo.
          ExcludeSemantics(
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          const SizedBox(height: PrimeSpacing.sm),
        ],
        // Associa semanticamente o label ao campo (leitores de tela).
        // O Text acima é decorativo; a semântica real vem deste Semantics.
        Semantics(
          label: label.isNotEmpty ? label : null,
          textField: true,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            maxLines: obscureText ? 1 : maxLines,
            minLines: 1,
            onChanged: onChanged,
            // Fecha o teclado quando o usuário toca fora do campo (UX premium).
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              hintText: hint,
              errorText: errorText,
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: context.cs.textMuted)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
