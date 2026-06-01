import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';
import '../ui/haptics.dart';

/// Wrapper de interação premium: scale-down ao pressionar, cancel quando o
/// dedo sai do bounding box (drag-out cancel), haptic leve no tap, e fica
/// não-interativo quando [onTap] é nulo.
///
/// Usado por [AppCard] interativo, FAB customizado, itens de lista, etc.
class AppPressable extends StatefulWidget {
  const AppPressable({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.scale = 0.97,
    this.haptic = true,
    this.behavior = HitTestBehavior.opaque,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scale;
  final bool haptic;
  final HitTestBehavior behavior;

  @override
  State<AppPressable> createState() => _AppPressableState();
}

class _AppPressableState extends State<AppPressable> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (_pressed == v) return;
    setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null || widget.onLongPress != null;

    return GestureDetector(
      behavior: widget.behavior,
      onTapDown: enabled ? (_) => _setPressed(true) : null,
      onTapUp: enabled ? (_) => _setPressed(false) : null,
      onTapCancel: enabled ? () => _setPressed(false) : null,
      onTap: widget.onTap == null
          ? null
          : () {
              if (widget.haptic) Haptics.tap();
              widget.onTap!();
            },
      onLongPress: widget.onLongPress == null
          ? null
          : () {
              if (widget.haptic) Haptics.select();
              widget.onLongPress!();
            },
      child: AnimatedScale(
        duration: AppMotion.fast,
        curve: AppMotion.curve,
        scale: _pressed ? widget.scale : 1.0,
        child: widget.child,
      ),
    );
  }
}
