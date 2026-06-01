import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';
import 'app_pressable.dart';

/// Card flat com borda fina + sombra opcional. Passe [onTap] pra versão
/// interativa — usa [AppPressable] (scale-down + haptic + drag-out cancel).
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    this.borderRadius = AppRadius.md,
    this.color,
    this.elevation = AppElevation.low,
    this.onTap,
    this.onLongPress,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? color;
  final AppElevation elevation;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final radius = BorderRadius.circular(borderRadius);

    final body = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? cs.surface,
        borderRadius: radius,
        border: Border.all(color: cs.border, width: 1),
        boxShadow: elevation.shadows(context),
      ),
      child: child,
    );

    if (onTap == null && onLongPress == null) return body;

    return AppPressable(onTap: onTap, onLongPress: onLongPress, child: body);
  }
}
