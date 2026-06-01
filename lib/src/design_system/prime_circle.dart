import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_tokens.dart';

/// Círculo flat: fundo neutro com borda, ou fundo de marca sólido quando
/// [active]. Sem gradientes, sem glow.
class PrimeCircle extends StatelessWidget {
  /// Cria um círculo flat.
  const PrimeCircle({
    super.key,
    required this.child,
    this.size = 40,
    this.active = false,
    this.activeColor,
    this.onTap,
  });

  /// Conteúdo centralizado dentro do círculo (ícone, texto etc.).
  final Widget child;

  /// Diâmetro do círculo em pixels lógicos.
  final double size;

  /// Quando `true`, usa fundo de marca sólido; caso contrário, fundo neutro
  /// com borda.
  final bool active;

  /// Cor quando ativo. `null` → usa a marca do tema (`context.cs.accent`).
  final Color? activeColor;

  /// Callback de toque. Quando `null`, o círculo não é interativo.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final accent = activeColor ?? cs.accent;

    Widget body = AnimatedContainer(
      duration: PrimeMotion.normalOf(context),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? accent : cs.surface,
        border: active ? null : Border.all(color: cs.border, width: 1),
      ),
      child: Center(child: child),
    );

    if (onTap != null) {
      body = GestureDetector(onTap: onTap, child: body);
    }
    return body;
  }
}
