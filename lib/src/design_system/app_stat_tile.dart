import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/design_tokens.dart';
import 'app_card.dart';

/// Tile de KPI: ícone colorido em box + valor em destaque + label.
class PrimeStatTile extends StatelessWidget {
  const PrimeStatTile({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    this.sub,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String? sub;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return PrimeCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: PrimeSpacing.lg,
        vertical: PrimeSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone puramente decorativo: o significado vem do label + valor.
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(PrimeRadius.xs),
            ),
            child: Icon(icon, color: color, size: 18, semanticLabel: ''),
          ),
          const SizedBox(height: PrimeSpacing.md),
          Text(value, style: PrimeText.stat.copyWith(color: cs.textPrimary)),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: PrimeText.s12,
              fontWeight: PrimeText.medium,
              color: cs.textSecondary,
            ),
          ),
          if (sub != null) ...[
            const SizedBox(height: 2),
            Text(
              sub!,
              style: TextStyle(fontSize: PrimeText.s11, color: cs.textMuted),
            ),
          ],
        ],
      ),
    );
  }
}
