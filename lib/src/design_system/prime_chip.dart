import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_text.dart';
import '../theme/prime_tokens.dart';

/// Chip selecionável flat. Selecionado = fundo [activeColor] sólido; inativo =
/// fundo surface + borda. Sem sombras coloridas.
class PrimeChip extends StatelessWidget {
  /// Cria um chip selecionável flat.
  const PrimeChip({
    super.key,
    required this.label,
    this.icon,
    this.active = false,
    this.activeColor,
    this.inactiveTextColor,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      horizontal: PrimeSpacing.md,
      vertical: PrimeSpacing.sm,
    ),
    this.fontSize = PrimeText.s13,
    this.borderRadius = PrimeRadius.pill,
  });

  /// Texto exibido no chip.
  final String label;

  /// Ícone opcional exibido antes do texto.
  final IconData? icon;

  /// Se o chip está selecionado (fundo sólido) ou inativo (borda).
  final bool active;

  /// Cor quando selecionado. `null` → usa a marca do tema (`context.cs.accent`).
  final Color? activeColor;

  /// Cor do texto/ícone quando inativo. `null` → `context.cs.textPrimary`.
  final Color? inactiveTextColor;

  /// Callback ao tocar; `null` desabilita a interação.
  final VoidCallback? onTap;

  /// Espaçamento interno do chip.
  final EdgeInsetsGeometry padding;

  /// Tamanho da fonte do texto (e base para o tamanho do ícone).
  final double fontSize;

  /// Raio de arredondamento das bordas.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final accent = activeColor ?? cs.accent;
    final fg = active
        ? PrimePalette.onAccent
        : (inactiveTextColor ?? cs.textPrimary);

    return Semantics(
      button: true,
      selected: active,
      label: label,
      child: GestureDetector(
        onTap: onTap == null
            ? null
            : () {
                HapticFeedback.selectionClick();
                onTap!();
              },
        child: AnimatedContainer(
          duration: PrimeMotion.normalOf(context),
          constraints: const BoxConstraints(minHeight: 36),
          padding: padding,
          decoration: BoxDecoration(
            color: active ? accent : cs.surface,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: active ? accent : cs.border, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: fontSize + 2, color: fg),
                const SizedBox(width: PrimeSpacing.xs + 2),
              ],
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
