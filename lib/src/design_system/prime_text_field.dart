import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_tokens.dart';

/// Campo de texto com label acima. Estilo herda do inputDecorationTheme.
class PrimeTextField extends StatelessWidget {
  /// Cria um campo de texto com label acima.
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

  /// Rótulo exibido acima do campo.
  final String label;

  /// Controlador do texto do campo.
  final TextEditingController? controller;

  /// Texto de placeholder exibido quando o campo está vazio.
  final String? hint;

  /// Mensagem de erro exibida abaixo do campo.
  final String? errorText;

  /// Se true, oculta o texto digitado (senhas).
  final bool obscureText;

  /// Tipo de teclado a ser exibido.
  final TextInputType? keyboardType;

  /// Formatadores aplicados à entrada do usuário.
  final List<TextInputFormatter>? inputFormatters;

  /// Ícone exibido no início do campo.
  final IconData? prefixIcon;

  /// Número máximo de caracteres aceitos.
  final int? maxLength;

  /// Número máximo de linhas do campo.
  final int maxLines;

  /// Callback disparado a cada alteração do texto.
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
