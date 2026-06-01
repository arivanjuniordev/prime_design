import 'package:flutter/widgets.dart';

/// `IndexedStack` **lazy**: só constrói o filho de um índice quando ele é
/// exibido pela primeira vez (os demais ficam como `SizedBox.shrink`). Uma vez
/// visitado, o filho permanece vivo (preserva estado/scroll), como abas.
///
/// Reduz a árvore inicial — ideal para navegação por abas/páginas onde a
/// maioria começa fora de tela. Inspirado no app Wonderous (gskinner).
///
/// ```dart
/// PrimeLazyIndexedStack(index: _tab, children: [PageA(), PageB(), PageC()]);
/// ```
class PrimeLazyIndexedStack extends StatefulWidget {
  /// Cria um stack indexado lazy.
  const PrimeLazyIndexedStack({
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const [],
  });

  /// Alinhamento dos filhos dentro do stack.
  final AlignmentGeometry alignment;

  /// Direção do texto usada pelo [alignment] (default: do contexto).
  final TextDirection? textDirection;

  /// Como o stack dimensiona os filhos não-posicionados.
  final StackFit sizing;

  /// Índice do filho atualmente visível.
  final int index;

  /// Filhos do stack. Só os já visitados são realmente construídos.
  final List<Widget> children;

  @override
  State<PrimeLazyIndexedStack> createState() => _PrimeLazyIndexedStackState();
}

class _PrimeLazyIndexedStackState extends State<PrimeLazyIndexedStack> {
  late List<bool> _activated = _initActivated();

  List<bool> _initActivated() =>
      List<bool>.generate(widget.children.length, (i) => i == widget.index);

  @override
  void didUpdateWidget(covariant PrimeLazyIndexedStack oldWidget) {
    if (oldWidget.children.length != widget.children.length) {
      _activated = _initActivated();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _activated[widget.index] = true;
    final children = List.generate(
      _activated.length,
      (i) => _activated[i] ? widget.children[i] : const SizedBox.shrink(),
    );
    return IndexedStack(
      alignment: widget.alignment,
      sizing: widget.sizing,
      textDirection: widget.textDirection,
      index: widget.index,
      children: children,
    );
  }
}
