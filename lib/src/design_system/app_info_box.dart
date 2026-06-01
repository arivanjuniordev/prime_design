import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/design_tokens.dart';

/// Dica/informação: fundo tonalizado em [color], borda fina colorida, ícone +
/// texto. Mais leve que [AppBanner] (sem ícone-box, sem título destacado).
class AppInfoBox extends StatelessWidget {
  const AppInfoBox({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    this.padding = AppSpacing.paddingMd,
    this.borderRadius = AppRadius.md,
    this.iconSize = 18,
    this.fontSize = AppText.s13,
    this.backgroundAlpha = 0.08,
    this.borderAlpha = 0.22,
  });

  final IconData icon;
  final String text;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double iconSize;
  final double fontSize;
  final double backgroundAlpha;
  final double borderAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withValues(alpha: backgroundAlpha),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: color.withValues(alpha: borderAlpha),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: iconSize, color: color),
          const SizedBox(width: AppSpacing.sm + 2),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                height: 1.45,
                color: context.cs.textPrimary,
                fontWeight: AppText.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
