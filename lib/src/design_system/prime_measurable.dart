import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Mede o tamanho final do [child] após o layout e notifica via [onChange].
///
/// Útil para layouts adaptativos que dependem do tamanho real de um widget
/// (sem `GlobalKey` nem `setState` redundante). Inspirado no app Wonderous
/// (gskinner).
///
/// ```dart
/// PrimeMeasurable(
///   onChange: (size) => setState(() => _textWidth = size.width),
///   child: Text(label),
/// );
/// ```
class PrimeMeasurable extends SingleChildRenderObjectWidget {
  /// Cria um medidor para [child], chamando [onChange] quando o tamanho muda.
  const PrimeMeasurable({
    super.key,
    required this.onChange,
    required Widget super.child,
  });

  /// Chamado (em microtask) sempre que o tamanho medido do filho muda.
  final void Function(Size size) onChange;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      PrimeMeasureSizeRenderObject(onChange);

  @override
  void updateRenderObject(
    BuildContext context,
    PrimeMeasureSizeRenderObject renderObject,
  ) {
    renderObject.onChange = onChange;
  }
}

/// RenderObject que reporta o tamanho do filho após cada layout que o altere.
class PrimeMeasureSizeRenderObject extends RenderProxyBox {
  /// Cria o render object com o callback inicial [onChange].
  PrimeMeasureSizeRenderObject(this.onChange);

  /// Callback notificado quando o tamanho do filho muda.
  void Function(Size size) onChange;

  Size _prevSize = Size.zero;

  @override
  void performLayout() {
    super.performLayout();
    final newSize = child?.size ?? Size.zero;
    if (_prevSize == newSize) return;
    _prevSize = newSize;
    scheduleMicrotask(() => onChange(newSize));
  }
}
