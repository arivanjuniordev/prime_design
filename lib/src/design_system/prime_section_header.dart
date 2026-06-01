import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_text.dart';
import '../theme/prime_tokens.dart';
import 'prime_icon_box.dart';

/// Header de seção: ícone-box + título + badge opcional com contagem.
class PrimeSectionHeader extends StatelessWidget {
  const PrimeSectionHeader({
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
        PrimeIconBox(
          icon: icon,
          color: color,
          size: 34,
          iconSize: 18,
          borderRadius: PrimeRadius.xs + 2,
        ),
        const SizedBox(width: PrimeSpacing.md),
        Flexible(
          child: Text(
            title,
            style: PrimeText.sectionTitle.copyWith(color: cs.textPrimary),
          ),
        ),
        if (badge != null) ...[
          const SizedBox(width: PrimeSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: PrimeSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(PrimeRadius.pill),
            ),
            child: Text(
              badge,
              style: TextStyle(
                fontSize: PrimeText.s11,
                fontWeight: PrimeText.bold,
                color: color,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
