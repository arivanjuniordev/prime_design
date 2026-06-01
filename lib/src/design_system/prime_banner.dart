import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_text.dart';
import '../theme/prime_tokens.dart';
import 'prime_icon_box.dart';

/// Banner horizontal: ícone-box + título + mensagem opcional + trailing.
/// Fundo tonalizado pela [color], borda fina colorida. Flat, sem sombra.
class PrimeBanner extends StatelessWidget {
  /// Cria um banner com ícone-box, título e mensagem opcional.
  const PrimeBanner({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    this.message,
    this.trailing,
    this.onTap,
    this.padding = PrimeSpacing.paddingMd,
    this.borderRadius = PrimeRadius.md,
    this.backgroundAlpha = 0.08,
    this.borderAlpha = 0.22,
  });

  /// Ícone exibido no ícone-box à esquerda.
  final IconData icon;

  /// Texto principal do banner.
  final String title;

  /// Cor base usada no ícone, no fundo tonalizado e na borda.
  final Color color;

  /// Mensagem secundária opcional, abaixo do título.
  final String? message;

  /// Widget exibido à direita do banner.
  final Widget? trailing;

  /// Callback de toque; quando nulo o banner é estático.
  final VoidCallback? onTap;

  /// Espaçamento interno do banner.
  final EdgeInsetsGeometry padding;

  /// Raio de canto do banner.
  final double borderRadius;

  /// Opacidade do fundo tonalizado pela [color].
  final double backgroundAlpha;

  /// Opacidade da borda colorida.
  final double borderAlpha;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final radius = BorderRadius.circular(borderRadius);

    Widget body = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withValues(alpha: backgroundAlpha),
        borderRadius: radius,
        border: Border.all(
          color: color.withValues(alpha: borderAlpha),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          PrimeIconBox(
            icon: icon,
            color: color,
            size: 36,
            iconSize: 18,
            borderRadius: PrimeRadius.sm - 2,
            backgroundAlpha: 0.18,
          ),
          const SizedBox(width: PrimeSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: PrimeText.s14,
                    fontWeight: PrimeText.bold,
                    color: cs.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    message!,
                    style: TextStyle(
                      fontSize: PrimeText.s12,
                      height: 1.4,
                      color: cs.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );

    if (onTap != null) {
      body = Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(onTap: onTap, borderRadius: radius, child: body),
      );
    }
    return body;
  }
}
