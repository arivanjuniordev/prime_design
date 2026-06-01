import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';
import '../ui/haptics.dart';

enum AppButtonVariant { primary, secondary, danger }

/// Botão flat universal (estilo guitarra) com API label-based (estilo Sharon).
/// Touch target mínimo 48, scale-down ao pressionar, suporte a loading/icon.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.loading = false,
    this.icon,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool loading;
  final IconData? icon;
  final bool fullWidth;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final enabled = widget.onPressed != null && !widget.loading;

    final bg = switch (widget.variant) {
      AppButtonVariant.primary => cs.accent,
      AppButtonVariant.secondary => cs.surface,
      AppButtonVariant.danger => AppColors.error,
    };
    final baseFg = widget.variant == AppButtonVariant.secondary
        ? cs.textPrimary
        : Colors.white;
    // Esmaece o conteúdo via alpha na cor quando desabilitado, em vez do widget
    // Opacity (que força saveLayer — flutter_perf.md §7).
    final fg = enabled ? baseFg : baseFg.withValues(alpha: 0.45);
    final showBorder = widget.variant == AppButtonVariant.secondary;

    Widget content = widget.loading
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: fg),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                widget.label,
                style: TextStyle(color: fg, fontWeight: FontWeight.w700),
              ),
            ],
          );

    Widget button = AnimatedScale(
      duration: AppMotion.fast,
      scale: _pressed ? 0.97 : 1.0,
      child: AnimatedContainer(
        duration: AppMotion.normal,
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xxl,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: showBorder ? Border.all(color: cs.border) : null,
          boxShadow: enabled && widget.variant != AppButtonVariant.secondary
              ? AppElevation.low.shadows(context)
              : null,
        ),
        child: Center(child: content),
      ),
    );

    button = GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: enabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
      onTap: enabled
          ? () {
              Haptics.tap();
              widget.onPressed!();
            }
          : null,
      child: button,
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      child: widget.fullWidth
          ? SizedBox(width: double.infinity, child: button)
          : button,
    );
  }
}
