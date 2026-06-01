import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/design_tokens.dart';
import 'app_icon_box.dart';

/// Header de seção: ícone-box + título + badge opcional com contagem.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.count,
    this.badgeText,
  });

  final String title;
  final IconData icon;
  final Color color;
  final int? count;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final badge = badgeText ?? (count != null ? '$count' : null);

    return Row(
      children: [
        AppIconBox(
          icon: icon,
          color: color,
          size: 34,
          iconSize: 18,
          borderRadius: AppRadius.xs + 2,
        ),
        const SizedBox(width: AppSpacing.md),
        Flexible(
          child: Text(
            title,
            style: AppText.sectionTitle.copyWith(color: cs.textPrimary),
          ),
        ),
        if (badge != null) ...[
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              badge,
              style: TextStyle(
                fontSize: AppText.s11,
                fontWeight: AppText.bold,
                color: color,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
