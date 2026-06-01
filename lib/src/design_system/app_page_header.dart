import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/design_tokens.dart';

/// Header de página: eyebrow + título grande + subtítulo + trailing.
class PrimePageHeader extends StatelessWidget {
  const PrimePageHeader({
    super.key,
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (eyebrow != null) ...[
                Text(
                  eyebrow!.toUpperCase(),
                  style: PrimeText.eyebrowColored(cs.textMuted),
                ),
                const SizedBox(height: PrimeSpacing.xs + 2),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: PrimeText.bold,
                  letterSpacing: -0.5,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: PrimeSpacing.xs),
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: PrimeText.s13,
                    color: cs.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: PrimeSpacing.md),
          trailing!,
        ],
      ],
    );
  }
}
