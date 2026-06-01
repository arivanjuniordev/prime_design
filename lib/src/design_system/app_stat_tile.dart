import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/design_tokens.dart';
import 'app_card.dart';

/// Tile de KPI: ícone colorido em box + valor em destaque + label.
class AppStatTile extends StatelessWidget {
  const AppStatTile({
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
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
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
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            child: Icon(icon, color: color, size: 18, semanticLabel: ''),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(value, style: AppText.stat.copyWith(color: cs.textPrimary)),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: AppText.s12,
              fontWeight: AppText.medium,
              color: cs.textSecondary,
            ),
          ),
          if (sub != null) ...[
            const SizedBox(height: 2),
            Text(
              sub!,
              style: TextStyle(fontSize: AppText.s11, color: cs.textMuted),
            ),
          ],
        ],
      ),
    );
  }
}
